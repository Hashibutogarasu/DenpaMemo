import 'dart:io';

import 'package:data_pack/data_pack.dart';
import 'package:dm_file/dm_file.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:path/path.dart' as path;

import '../i18n/gen/strings.g.dart';
import '../widgets/dialog/export_complete_dialog.dart';
import 'app_notification_providers.dart';
import 'denpa_men_icon_providers.dart';
import 'denpa_men_providers.dart';
import 'import_export_progress_providers.dart';
import 'qr_code_providers.dart';

const _notificationKind = 'dm_export';

/// Drives the "export selected individuals to a `.dm` file" flow: prompts
/// for a save location (defaulting the file name via
/// [DMFile.defaultExportFileName]), then delegates the actual data
/// processing to [DMFile.writeExport], reporting progress through
/// [importExportProgressProvider] and [appNotificationsProvider].
class DmExportController {
  const DmExportController(this._ref);

  final Ref _ref;

  /// Returns the [ExportResult] once the export completes, or null if the
  /// user cancelled the save dialog.
  Future<ExportResult?> exportSelected(
    MasterData masterData, {
    required String dialogTitle,
  }) async {
    final progress = _ref.read(importExportProgressProvider.notifier);
    final notifications = _ref.read(appNotificationsProvider.notifier);
    progress.state = 0;
    notifications.setStatus(
      _notificationKind,
      status: AppNotificationStatus.running,
      progress: 0,
    );

    final selectedIds = _ref.read(selectedDenpaMenIdsProvider);
    final records = _ref.read(denpaMenRepositoryProvider).getAll(masterData);
    final candidates = [
      for (final record in records)
        if (selectedIds.contains(record.id)) record.denpaMen,
    ];

    final fileName = DMFile.defaultExportFileName(
      exportedAt: DateTime.now(),
      individualCount: candidates.length,
    );

    String? copyToPath;
    if (Platform.isAndroid) {
      final directoryPath = await FilePicker.getDirectoryPath(
        dialogTitle: dialogTitle,
      );
      if (directoryPath == null) {
        progress.state = null;
        notifications.setStatus(
          _notificationKind,
          status: AppNotificationStatus.cancelled,
        );
        return null;
      }
      copyToPath = path.join(directoryPath, fileName);
    }

    try {
      final packageInfo = await PackageInfo.fromPlatform();
      final qrCodes = _ref.read(qrCodeRepositoryProvider).getAll();
      final storage = _ref.read(denpaMenIconStorageProvider);
      final (result, zipBytes) = await DMFile.writeExport(
        candidates: candidates,
        masterData: masterData,
        qrCodes: [for (final record in qrCodes) record.qrCode],
        loadIcons: (denpaMenId) =>
            loadAllDenpaMenImageSlots(storage, denpaMenId),
        dataVersion: packageInfo.version,
        onProgress: (value) {
          progress.state = value;
          if (value != null) {
            notifications.setStatus(
              _notificationKind,
              status: AppNotificationStatus.running,
              progress: value,
            );
          }
        },
        copyToPath: copyToPath,
      );

      if (copyToPath != null) {
        notifications.setStatus(
          _notificationKind,
          status: AppNotificationStatus.completed,
          progress: 1,
        );
        return result;
      }

      final savePath = await FilePicker.saveFile(
        dialogTitle: dialogTitle,
        fileName: fileName,
        type: FileType.custom,
        allowedExtensions: [DMFile.extension],
        bytes: zipBytes,
      );
      if (savePath == null) {
        notifications.setStatus(
          _notificationKind,
          status: AppNotificationStatus.cancelled,
        );
        return null;
      }
      notifications.setStatus(
        _notificationKind,
        status: AppNotificationStatus.completed,
        progress: 1,
      );
      return result;
    } catch (error) {
      notifications.setStatus(
        _notificationKind,
        status: AppNotificationStatus.failed,
        message: '$error',
      );
      rethrow;
    } finally {
      progress.state = null;
    }
  }
}

final dmExportControllerProvider = Provider<DmExportController>(
  (ref) => DmExportController(ref),
);

/// Runs [DmExportController.exportSelected] and, once it resolves, shows
/// the result via [ExportCompleteDialog.show]. Shared by every place that
/// offers an "export selected individuals" action (the home page's
/// overflow menu/FAB and the lineage tree's context menu) so they all go
/// through the exact same flow.
Future<void> exportSelectedDenpaMen(
  BuildContext context,
  WidgetRef ref,
  MasterData masterData,
) async {
  final t = context.t;
  final result = await ref
      .read(dmExportControllerProvider)
      .exportSelected(masterData, dialogTitle: t.home.exportDialogTitle);
  if (result != null && context.mounted) {
    await ExportCompleteDialog.show(context, ref, result: result);
  }
}
