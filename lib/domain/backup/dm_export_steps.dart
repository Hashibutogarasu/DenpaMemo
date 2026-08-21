import 'dart:convert';
import 'dart:io';

import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';

import '../denpa_men/denpa_men.dart';
import '../denpa_men/denpa_men_backup_builder.dart';
import '../denpa_men/denpa_men_backup_codec.dart';
import 'dm_export_context.dart';
import 'dm_export_step.dart';
import 'dm_export_validation.dart';
import 'dm_header_codec.dart';
import 'dm_zip_io.dart';
import 'export_result.dart';

/// Filters `context.candidates` down to those consistent with
/// `context.masterData`, and builds `context.exportResult` from the
/// consistent/orphaned split.
class FilterConsistentIndividualsStep extends DmExportStep {
  @override
  Future<void> run(DmExportContext context) async {
    final consistent = <DenpaMen>[];
    final candidates = context.candidates;
    for (var i = 0; i < candidates.length; i++) {
      if (isDenpaMenConsistentWithMasterData(
        candidates[i],
        context.masterData,
      )) {
        consistent.add(candidates[i]);
      }
      reportProgress(entryIndex: i, entryCount: candidates.length);
    }
    context.consistent = consistent;

    final exportedIds = {for (final d in consistent) d.id};
    context.exportResult = ExportResult(
      exported: consistent,
      orphaned: [
        for (final denpaMen in consistent)
          if (isDenpaMenOrphanedInExport(denpaMen, exportedIds)) denpaMen,
      ],
    );
  }
}

/// Creates the temporary work directory the export is assembled in.
class CreateWorkDirectoryStep extends DmExportStep {
  @override
  Future<void> run(DmExportContext context) async {
    final tempRoot = await getTemporaryDirectory();
    final workDirectory = Directory(
      path.join(
        tempRoot.path,
        'dm_export_${DateTime.now().microsecondsSinceEpoch}',
      ),
    );
    await workDirectory.create(recursive: true);
    context.tempRoot = tempRoot;
    context.workDirectory = workDirectory;
    reportProgress();
  }

  @override
  Future<void> cleanup(DmExportContext context) async {
    final workDirectory = context.workDirectory;
    if (workDirectory != null && await workDirectory.exists()) {
      await workDirectory.delete(recursive: true);
    }
  }
}

/// Builds the backup entries from `context.consistent`/`context.qrCodes`
/// and writes them to `entries.json` in the work directory.
class WriteEntriesJsonStep extends DmExportStep {
  @override
  Future<void> run(DmExportContext context) async {
    final entries = buildDenpaMenBackupEntries(
      context.consistent!,
      context.qrCodes,
    );
    context.entries = entries;

    final entriesFile = File(
      path.join(context.workDirectory!.path, 'entries.json'),
    );
    await entriesFile.writeAsString(jsonEncode(encodeDenpaMenBackup(entries)));
    reportProgress();
  }
}

/// Copies each exported individual's icon file (if any) into the work
/// directory, alongside a `metadata.json` recording its file name.
class CopyIconsStep extends DmExportStep {
  @override
  Future<void> run(DmExportContext context) async {
    final entries = context.entries!;
    for (var i = 0; i < entries.length; i++) {
      final denpaMenId = entries[i].denpaMen.id;
      final iconFile = await context.loadIcon(denpaMenId);
      if (iconFile != null) {
        final iconDirectory = Directory(
          path.join(
            context.workDirectory!.path,
            'icons',
            'denpamens',
            denpaMenId,
          ),
        );
        await iconDirectory.create(recursive: true);
        final destName = 'icon${path.extension(iconFile.path)}';
        await iconFile.copy(path.join(iconDirectory.path, destName));
        await File(
          path.join(iconDirectory.path, 'metadata.json'),
        ).writeAsString(jsonEncode({'fileName': destName}));
      }
      reportProgress(entryIndex: i, entryCount: entries.length);
    }
  }
}

/// Encodes the `.dm` header and zips the work directory into the temp
/// output file.
class WriteZipStep extends DmExportStep {
  @override
  Future<void> run(DmExportContext context) async {
    final header = encodeDmHeader(context.dataVersion);
    final zipFile = File(
      path.join(context.tempRoot!.path, 'dm_export_output.$dmFileExtension'),
    );
    await writeDmZip(
      sourceDirectory: context.workDirectory!,
      outputFile: zipFile,
      headerComment: header,
    );
    context.zipFile = zipFile;
    reportProgress();
  }

  @override
  Future<void> cleanup(DmExportContext context) async {
    final zipFile = context.zipFile;
    if (zipFile != null && await zipFile.exists()) {
      await zipFile.delete();
    }
  }
}

/// Reads the finished zip into memory before its temp file is cleaned up,
/// so the caller can hand the bytes to `FilePicker.saveFile` (required on
/// Android/iOS, where there is no writable path to copy into directly).
class ReadZipBytesStep extends DmExportStep {
  @override
  Future<void> run(DmExportContext context) async {
    context.zipBytes = await context.zipFile!.readAsBytes();
    reportProgress();
  }
}

/// Copies the finished zip to `context.copyToPath` before its temp file is
/// cleaned up. Only runs when `copyToPath` is set.
class CopyZipToPathStep extends DmExportStep {
  @override
  Future<void> run(DmExportContext context) async {
    final destination = File(context.copyToPath!);
    await destination.parent.create(recursive: true);
    await context.zipFile!.copy(destination.path);
    reportProgress();
  }
}
