import 'dart:convert';
import 'dart:io';

import 'package:data_pack/data_pack.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';

import '../denpa_men_backup_codec.dart';
import '../dm_file.dart';
import 'dm_import_context.dart';
import 'dm_import_step.dart';
import 'import_result_builder.dart';

/// Creates the temporary directory `context.inputFile`'s zip is extracted
/// into.
class CreateExtractDirectoryStep extends DmImportStep {
  @override
  Future<void> run(DmImportContext context) async {
    final tempRoot = await getTemporaryDirectory();
    final extractDirectory = Directory(
      path.join(
        tempRoot.path,
        'dm_import_${DateTime.now().microsecondsSinceEpoch}',
      ),
    );
    context.tempRoot = tempRoot;
    context.extractDirectory = extractDirectory;
    reportProgress();
  }

  @override
  Future<void> cleanup(DmImportContext context) async {
    final extractDirectory = context.extractDirectory;
    if (extractDirectory != null && await extractDirectory.exists()) {
      await extractDirectory.delete(recursive: true);
    }
  }
}

/// Extracts `context.inputFile`'s zip into `context.extractDirectory` and
/// decodes its `.dm` header. Throws `DmHeaderReadError` (via
/// `DMFile.decodeHeader`) if the header is missing or malformed.
class ExtractZipStep extends DmImportStep {
  @override
  Future<void> run(DmImportContext context) async {
    final readResult = await readDmZip(
      inputFile: context.inputFile,
      outputDirectory: context.extractDirectory!,
    );
    DMFile.decodeHeader(readResult.headerComment);
    context.headerComment = readResult.headerComment;
    reportProgress();
  }
}

/// Decodes `entries.json` from the extracted directory. Throws
/// `DmInvalidImportFileException` when the file is missing, or its
/// contents don't even parse as a JSON array of entries.
class DecodeEntriesStep extends DmImportStep {
  @override
  Future<void> run(DmImportContext context) async {
    final entriesFile = File(
      path.join(context.extractDirectory!.path, 'entries.json'),
    );
    if (!await entriesFile.exists()) {
      throw const DmInvalidImportFileException();
    }
    final decodeResult = decodeDenpaMenBackup(await entriesFile.readAsString());
    if (decodeResult == null ||
        (decodeResult.entries.isEmpty && decodeResult.failed.isEmpty)) {
      throw const DmInvalidImportFileException();
    }
    context.entries = decodeResult.entries;
    context.failedEntries = decodeResult.failed;
    context.candidates = [for (final e in decodeResult.entries) e.denpaMen];
    reportProgress();
  }
}

/// Resolves each entry's icon file (if any) from the extracted directory,
/// matching `CopyIconsStep`'s written layout on the export side.
class ResolveIconsStep extends DmImportStep {
  @override
  Future<void> run(DmImportContext context) async {
    final entries = context.entries!;
    final iconsByDenpaMenId = <String, File>{};
    for (var i = 0; i < entries.length; i++) {
      final denpaMenId = entries[i].denpaMen.id;
      final iconDirectory = Directory(
        path.join(
          context.extractDirectory!.path,
          'icons',
          'denpamens',
          denpaMenId,
        ),
      );
      final metadataFile = File(path.join(iconDirectory.path, 'metadata.json'));
      if (await metadataFile.exists()) {
        final metadata =
            jsonDecode(await metadataFile.readAsString())
                as Map<String, dynamic>;
        final fileName = metadata['fileName'] as String?;
        if (fileName != null) {
          final iconFile = File(path.join(iconDirectory.path, fileName));
          if (await iconFile.exists()) {
            iconsByDenpaMenId[denpaMenId] = iconFile;
          }
        }
      }
      reportProgress(entryIndex: i, entryCount: entries.length);
    }
    context.iconsByDenpaMenId = iconsByDenpaMenId;
  }
}

/// Picks which of `context.candidates` to import: all of them if none
/// already exist locally, otherwise whatever `context.resolveDuplicates`
/// returns. Throws `DmImportCancelled` if the user declines to resolve
/// them.
class ResolveDuplicatesStep extends DmImportStep {
  @override
  Future<void> run(DmImportContext context) async {
    final candidates = context.candidates!;
    if (!hasAnyDuplicateDenpaMen(
      candidates,
      context.denpaMenRepository,
      context.masterData,
    )) {
      context.toImport = candidates;
      reportProgress();
      return;
    }

    final selected = await context.resolveDuplicates(candidates);
    if (selected == null || selected.isEmpty) {
      throw const DmImportCancelled();
    }
    context.toImport = selected;
    reportProgress();
  }
}

/// Merges every entry in `context.toImport` into local storage.
class MergeEntriesStep extends DmImportStep {
  @override
  Future<void> run(DmImportContext context) async {
    final toImportIds = {for (final d in context.toImport!) d.id};
    final selectedEntries = [
      for (final e in context.entries!)
        if (toImportIds.contains(e.denpaMen.id)) e,
    ];
    context.selectedEntries = selectedEntries;

    final mergeResults = <DenpaMenMergeResult>[];
    for (var i = 0; i < selectedEntries.length; i++) {
      mergeResults.addAll(
        mergeDenpaMenBackupEntries(
          [selectedEntries[i]],
          denpaMenRepository: context.denpaMenRepository,
          qrCodeRepository: context.qrCodeRepository,
          masterData: context.masterData,
        ),
      );
      reportProgress(entryIndex: i, entryCount: selectedEntries.length);
    }
    context.mergeResults = mergeResults;
  }
}

/// Saves each merged entry's resolved icon file, if any.
class SaveIconsStep extends DmImportStep {
  @override
  Future<void> run(DmImportContext context) async {
    final entries = context.selectedEntries!;
    final iconsByDenpaMenId = context.iconsByDenpaMenId!;
    for (var i = 0; i < entries.length; i++) {
      final iconFile = iconsByDenpaMenId[entries[i].denpaMen.id];
      if (iconFile != null) {
        await context.saveIcon(entries[i].denpaMen.id, iconFile);
      }
      reportProgress(entryIndex: i, entryCount: entries.length);
    }
  }
}

/// Warms the icon cache for every merged entry that has an icon, so it's
/// ready to display as soon as the import completes.
class WarmIconCacheStep extends DmImportStep {
  @override
  Future<void> run(DmImportContext context) async {
    final entries = context.selectedEntries!;
    final iconsByDenpaMenId = context.iconsByDenpaMenId!;
    for (var i = 0; i < entries.length; i++) {
      final denpaMenId = entries[i].denpaMen.id;
      final record = context.denpaMenRepository.findByCuid(
        denpaMenId,
        context.masterData,
      );
      if (record != null && iconsByDenpaMenId.containsKey(denpaMenId)) {
        await context.loadIcon(denpaMenId);
      }
      reportProgress(entryIndex: i, entryCount: entries.length);
    }
  }
}

/// Builds `context.importResult` from every entry's merge outcome plus
/// whatever failed to parse.
class BuildImportResultStep extends DmImportStep {
  @override
  Future<void> run(DmImportContext context) async {
    context.importResult = buildImportResult(
      context.mergeResults!,
      context.failedEntries!,
      repository: context.denpaMenRepository,
      masterData: context.masterData,
    );
    reportProgress();
  }
}
