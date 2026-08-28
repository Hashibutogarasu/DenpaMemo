import 'dart:io';

import 'package:collection/collection.dart';
import 'package:data_pack/data_pack.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../domain/backup/dm_file.dart';
import '../domain/backup/dm_import_error.dart';
import '../domain/backup/import_result.dart';
import '../i18n/gen/strings.g.dart';
import '../widgets/dialog/denpa_men_selection_dialog.dart';
import '../widgets/dialog/error_dialog.dart';
import 'denpa_men_icon_providers.dart';
import 'denpa_men_providers.dart';
import 'import_export_progress_providers.dart';
import 'master_data_providers.dart';
import 'qr_code_providers.dart';

/// Drives the "import individuals from a `.dm` file" flow: prompts for a
/// file to open, then delegates the actual data processing to
/// [DMFile.readImport], reporting progress through
/// [importExportProgressProvider] throughout. Any UI the import needs
/// mid-way (resolving duplicate individuals, surfacing an invalid-file or
/// header error) is handled here, so callers only ever see the final
/// [ImportResult].
class DmImportController {
  const DmImportController(this._ref);

  final Ref _ref;

  /// Returns the [ImportResult] once the import completes, or null if the
  /// user cancelled file selection, declined to resolve duplicates, or the
  /// file was rejected (an error/snackbar is shown before returning null in
  /// the latter cases).
  Future<ImportResult?> importFromFile(BuildContext context) async {
    final t = context.t;

    final result = await FilePicker.pickFiles(
      type: FileType.custom,
      allowedExtensions: [DMFile.extension],
    );
    final pickedFile = result?.files.firstOrNull;
    final pickedPath = pickedFile?.path;
    if (pickedPath == null) {
      return null;
    }

    final masterData = _ref.read(masterDataProvider).value!;

    final progress = _ref.read(importExportProgressProvider.notifier);
    progress.state = 0;

    try {
      final storage = _ref.read(denpaMenIconStorageProvider);
      return await DMFile.readImport(
        inputFile: File(pickedPath),
        masterData: masterData,
        denpaMenRepository: _ref.read(denpaMenRepositoryProvider),
        qrCodeRepository: _ref.read(qrCodeRepositoryProvider),
        loadIcon: storage.loadIcon,
        saveIcon: (denpaMenId, iconFile) async {
          await storage.saveIcon(denpaMenId, iconFile);
          _ref.invalidate(denpaMenIconProvider(denpaMenId));
        },
        resolveDuplicates: (candidates) => DenpaMenSelectionDialog.show(
          context,
          title: t.home.importMergeConfirmTitle,
          candidates: candidates,
          initial: candidates,
        ),
        onProgress: (value) => progress.state = value,
      );
    } on DmImportError catch (error) {
      if (context.mounted) {
        await ErrorDialog.show(context, error: error);
      }
      return null;
    } on DmInvalidImportFileException {
      if (context.mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(t.home.importInvalidFile)));
      }
      return null;
    } finally {
      progress.state = null;
    }
  }
}

final dmImportControllerProvider = Provider<DmImportController>(
  (ref) => DmImportController(ref),
);
