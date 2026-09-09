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

/// Resolves each entry's image slots from the extracted directory,
/// matching `CopyIconsStep`'s written layout on the export side. Slot
/// keys are opaque strings read directly from the archive's directory
/// names — this step never enumerates or interprets which ones exist,
/// except for the single [legacyIconSlotKey] fallback for pre-multi-slot
/// archives (a `.dm` file written before per-slot images existed, with a
/// single icon directly under `icons/denpamens/<id>/` and no slot
/// subdirectory). [legacyIconSlotKey]'s value is DMFile's own
/// backward-compat convention — it happens to match the app layer's
/// `DenpaMenImageSlotType.icon.name`, but DMFile defines it independently
/// and never imports that enum.
class ResolveIconsStep extends DmImportStep {
  static const String legacyIconSlotKey = 'icon';

  @override
  Future<void> run(DmImportContext context) async {
    final entries = context.entries!;
    final iconsByDenpaMenId = <String, Map<String, File>>{};
    for (var i = 0; i < entries.length; i++) {
      context.onIndividualStarted?.call(entries[i].denpaMen);
      final denpaMenId = entries[i].denpaMen.id;
      final individualDirectory = Directory(
        path.join(
          context.extractDirectory!.path,
          'icons',
          'denpamens',
          denpaMenId,
        ),
      );
      final icons = <String, File>{};
      if (await individualDirectory.exists()) {
        await for (final entity in individualDirectory.list()) {
          if (entity is! Directory) {
            continue;
          }
          final slotKey = path.basename(entity.path);
          final metadataFile = File(path.join(entity.path, 'metadata.json'));
          if (!await metadataFile.exists()) {
            continue;
          }
          final metadata =
              jsonDecode(await metadataFile.readAsString())
                  as Map<String, dynamic>;
          final fileName = metadata['fileName'] as String?;
          if (fileName == null) {
            continue;
          }
          final iconFile = File(path.join(entity.path, fileName));
          if (await iconFile.exists()) {
            icons[slotKey] = iconFile;
          }
        }
      }
      if (icons.isEmpty) {
        final legacyMetadataFile = File(
          path.join(individualDirectory.path, 'metadata.json'),
        );
        if (await legacyMetadataFile.exists()) {
          final metadata =
              jsonDecode(await legacyMetadataFile.readAsString())
                  as Map<String, dynamic>;
          final fileName = metadata['fileName'] as String?;
          if (fileName != null) {
            final legacyIconFile = File(
              path.join(individualDirectory.path, fileName),
            );
            if (await legacyIconFile.exists()) {
              icons[legacyIconSlotKey] = legacyIconFile;
            }
          }
        }
      }
      iconsByDenpaMenId[denpaMenId] = icons;
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
      context.onIndividualStarted?.call(selectedEntries[i].denpaMen);
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

/// Saves each merged entry's resolved image slots, if any.
class SaveIconsStep extends DmImportStep {
  @override
  Future<void> run(DmImportContext context) async {
    final entries = context.selectedEntries!;
    final iconsByDenpaMenId = context.iconsByDenpaMenId!;
    for (var i = 0; i < entries.length; i++) {
      context.onIndividualStarted?.call(entries[i].denpaMen);
      final icons = iconsByDenpaMenId[entries[i].denpaMen.id];
      if (icons != null && icons.isNotEmpty) {
        await context.saveIcons(entries[i].denpaMen.id, icons);
      }
      reportProgress(entryIndex: i, entryCount: entries.length);
    }
  }
}

/// Warms the icon cache for every merged entry that has at least one
/// image slot, so it's ready to display as soon as the import completes.
class WarmIconCacheStep extends DmImportStep {
  @override
  Future<void> run(DmImportContext context) async {
    final entries = context.selectedEntries!;
    final iconsByDenpaMenId = context.iconsByDenpaMenId!;
    for (var i = 0; i < entries.length; i++) {
      context.onIndividualStarted?.call(entries[i].denpaMen);
      final denpaMenId = entries[i].denpaMen.id;
      final record = context.denpaMenRepository.findByCuid(
        denpaMenId,
        context.masterData,
      );
      final icons = iconsByDenpaMenId[denpaMenId];
      if (record != null && icons != null && icons.isNotEmpty) {
        await context.loadIcons(denpaMenId);
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
