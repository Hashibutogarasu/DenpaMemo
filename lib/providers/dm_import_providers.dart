import 'dart:io';

import 'package:collection/collection.dart';
import 'package:data_pack/data_pack.dart';
import 'package:denpamemo_widgets/denpamemo_widgets.dart'
    hide Translations, BuildContextTranslationsExtension;
import 'package:dm_file/dm_file.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:graphql_client/graphql_client.dart';
import 'package:step_dialog/step_dialog.dart'
    hide Translations, BuildContextTranslationsExtension;

import '../i18n/gen/strings.g.dart';
import 'app_notification_providers.dart';
import 'denpa_men_icon_providers.dart';
import 'denpa_men_providers.dart';
import 'import_export_progress_providers.dart';
import 'qr_code_providers.dart';

const _notificationKind = 'dm_import';

/// Drives the "import individuals from a `.dm` file" flow: prompts for a
/// file to open, then delegates the actual data processing to
/// [DMFile.readImport], reporting progress through
/// [importExportProgressProvider] and [appNotificationsProvider]. Any UI
/// the import needs mid-way (resolving duplicate individuals, surfacing an
/// invalid-file or header error) is handled here, so callers only ever see
/// the final [ImportResult].
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
    final notifications = _ref.read(appNotificationsProvider.notifier);
    progress.state = 0;
    notifications.setStatus(_notificationKind, status: AppNotificationStatus.running, progress: 0);

    try {
      final storage = _ref.read(denpaMenIconStorageProvider);
      final result = await DMFile.readImport(
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
          totalAttributeCount: masterData.attributes.length,
        ),
        onProgress: (value) {
          progress.state = value;
          if (value != null) {
            notifications.setStatus(_notificationKind, status: AppNotificationStatus.running, progress: value);
          }
        },
      );
      notifications.setStatus(
        _notificationKind,
        status: result == null ? AppNotificationStatus.cancelled : AppNotificationStatus.completed,
        progress: result == null ? null : 1,
      );
      return result;
    } on DmHeaderReadError {
      notifications.setStatus(
        _notificationKind,
        status: AppNotificationStatus.failed,
        message: t.backup.importHeaderErrorDescription,
      );
      if (context.mounted) {
        await ErrorDialog.show(
          context,
          title: t.backup.importHeaderErrorTitle,
          description: t.backup.importHeaderErrorDescription,
        );
      }
      return null;
    } on DmInvalidImportFileException {
      notifications.setStatus(
        _notificationKind,
        status: AppNotificationStatus.failed,
        message: t.home.importInvalidFile,
      );
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
