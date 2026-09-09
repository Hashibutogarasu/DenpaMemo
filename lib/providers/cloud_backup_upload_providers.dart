import 'package:collection/collection.dart';
import 'package:data_pack/data_pack.dart';
import 'package:dm_file/dm_file.dart';
import 'package:firebase_sign_in/firebase_sign_in.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:package_info_plus/package_info_plus.dart';

import 'app_notification_providers.dart';
import 'cancellation.dart';
import 'cloud_files_providers.dart';
import 'denpa_men_icon_providers.dart';
import 'denpa_men_providers.dart';
import 'operation_progress_providers.dart';
import 'pending_operation_result_providers.dart';
import 'qr_code_providers.dart';
import 'rolling_transfer_rate.dart';

const _notificationKind = 'cloud_backup_upload';

/// The upload's [AppNotification] within [notifications] (as read from
/// [appNotificationsProvider]), if any.
AppNotification? cloudBackupUploadNotificationOf(
  List<AppNotification> notifications,
) => notifications.firstWhereOrNull((n) => n.kind == _notificationKind);

/// Packages every individual into a `.dm` archive with [DMFile.writeExport]
/// (the same step pipeline `DmExportController` uses for a selection-only
/// export) and uploads it via [CloudFilesNotifier.uploadDmFile], reporting
/// progress and outcome through [appNotificationsProvider].
class CloudBackupUploadController {
  const CloudBackupUploadController(this._ref);

  final Ref _ref;

  /// Returns the [ExportResult] once the archive has been uploaded. Throws
  /// [CancelledException] if [cancellation] is requested before the
  /// upload starts.
  Future<ExportResult> upload(
    MasterData masterData, {
    required Cancellation cancellation,
  }) async {
    final notifications = _ref.read(appNotificationsProvider.notifier);
    notifications.setStatus(
      _notificationKind,
      status: AppNotificationStatus.running,
      progress: 0,
    );

    final progressDetail = _ref.read(operationProgressProvider.notifier);
    final itemRate = CumulativeItemRate();
    try {
      final records = _ref.read(denpaMenRepositoryProvider).getAll(masterData);
      final candidates = [for (final record in records) record.denpaMen];
      final qrCodes = _ref.read(qrCodeRepositoryProvider).getAll();
      final storage = _ref.read(denpaMenIconStorageProvider);
      final packageInfo = await PackageInfo.fromPlatform();

      final (result, zipBytes) = await DMFile.writeExport(
        candidates: candidates,
        masterData: masterData,
        qrCodes: [for (final record in qrCodes) record.qrCode],
        loadIcons: (denpaMenId) =>
            loadAllDenpaMenImageSlots(storage, denpaMenId),
        dataVersion: packageInfo.version,
        onIndividualStarted: (individual) {
          progressDetail.report(
            _notificationKind,
            currentIndividualId: individual.id,
            currentIndividualName: individual.name,
            itemsPerSecond: itemRate.started(),
          );
        },
        onProgress: (value) {
          if (value == null) return;
          notifications.setStatus(
            _notificationKind,
            status: AppNotificationStatus.running,
            progress: value * 0.5,
          );
        },
      );
      if (cancellation.isRequested) {
        throw const CancelledException();
      }

      final filename = DMFile.defaultExportFileName(
        exportedAt: DateTime.now(),
        individualCount: candidates.length,
      );
      final uploadRate = RollingTransferRate();
      await _ref
          .read(cloudFilesProvider.notifier)
          .uploadDmFile(
            filename,
            zipBytes,
            onProgress: (sent, total) {
              final bytesPerSecond = uploadRate.sample(sent);
              if (bytesPerSecond == null) return;
              progressDetail.report(
                _notificationKind,
                bytesPerSecond: bytesPerSecond,
              );
            },
          );

      _ref
          .read(pendingOperationResultProvider.notifier)
          .set(_notificationKind, result);
      notifications.setStatus(
        _notificationKind,
        status: AppNotificationStatus.completed,
        progress: 1,
      );
      return result;
    } on CancelledException {
      notifications.setStatus(
        _notificationKind,
        status: AppNotificationStatus.cancelled,
      );
      rethrow;
    } on NotSignedInException {
      notifications.setStatus(
        _notificationKind,
        status: AppNotificationStatus.failed,
        errorKind: 'not_signed_in',
      );
      rethrow;
    } catch (error) {
      notifications.setStatus(
        _notificationKind,
        status: AppNotificationStatus.failed,
        errorKind: 'network_error',
        message: '$error',
      );
      rethrow;
    } finally {
      progressDetail.clear(_notificationKind);
    }
  }
}

final cloudBackupUploadControllerProvider =
    Provider<CloudBackupUploadController>(
      (ref) => CloudBackupUploadController(ref),
    );
