import 'package:flutter/material.dart';

import 'package:data_pack/data_pack.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../i18n/gen/strings.g.dart';
import '../../providers/cancellation.dart';
import '../../providers/cloud_backup_restore_providers.dart';
import '../../providers/cloud_backup_upload_providers.dart';
import '../../providers/notification_service_providers.dart';
import '../../services/live_progress_forwarding.dart';

void showCancellableSnackBar(
  BuildContext context,
  String message,
  VoidCallback onCancel,
) {
  final t = context.t;
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(message),
      duration: const Duration(minutes: 10),
      action: SnackBarAction(label: t.common.cancel, onPressed: onCancel),
    ),
  );
}

/// Runs [CloudBackupUploadController.upload] with a cancellable snackbar.
/// The outcome (success, cancellation, or any specific failure) is recorded
/// by the controller itself into [appNotificationsProvider]
/// (../../providers/app_notification_providers.dart), and displayed by the
/// global result listener in `main.dart` — not here — so it survives the
/// caller navigating away before the upload finishes. The only sanctioned
/// way to start a backup upload, so every entry point shows the same
/// snackbar/progress handling.
Future<void> runCloudBackup(
  BuildContext context,
  WidgetRef ref,
  MasterData masterData,
) async {
  final t = context.t;
  final cancellation = Cancellation();
  showCancellableSnackBar(
    context,
    t.cloudBackup.backupRunning,
    cancellation.request,
  );
  try {
    await ref
        .read(foregroundServiceProvider)
        .runAsync(
          notificationId: 'cloud_backup_upload',
          notificationTitle: t.cloudBackup.backupRunning,
          task: (taskContext) async {
            final subscriptions = forwardLiveProgressToNotification(
              ref,
              'cloud_backup_upload',
              taskContext,
            );
            try {
              return await ref
                  .read(cloudBackupUploadControllerProvider)
                  .upload(masterData, cancellation: cancellation);
            } finally {
              for (final subscription in subscriptions) {
                subscription.close();
              }
            }
          },
        );
  } catch (_) {
    // Already recorded into appNotificationsProvider by the controller;
    // the global result listener shows the appropriate dialog/snackbar.
  } finally {
    if (context.mounted) {
      ScaffoldMessenger.of(context).removeCurrentSnackBar();
    }
  }
}

/// Runs [CloudBackupRestoreController.restore] (restoring [target] if
/// given, otherwise the latest cloud backup) with a cancellable snackbar.
/// See [runCloudBackup]'s doc comment for why the outcome is displayed by
/// the global result listener rather than here. Shared by `CloudBackupPage`'s
/// "restore latest" endpoint and the backup history page's per-item
/// "restore" action, so both go through the exact same flow.
Future<void> runCloudRestore(
  BuildContext context,
  WidgetRef ref, {
  CloudFile? target,
}) async {
  final t = context.t;
  final cancellation = Cancellation();
  showCancellableSnackBar(
    context,
    t.cloudBackup.restoreRunning,
    cancellation.request,
  );
  try {
    await ref
        .read(foregroundServiceProvider)
        .runAsync(
          notificationId: 'cloud_backup_restore',
          notificationTitle: t.cloudBackup.restoreRunning,
          task: (taskContext) async {
            final subscriptions = forwardLiveProgressToNotification(
              ref,
              'cloud_backup_restore',
              taskContext,
            );
            try {
              return await ref
                  .read(cloudBackupRestoreControllerProvider)
                  .restore(context, cancellation: cancellation, target: target);
            } finally {
              for (final subscription in subscriptions) {
                subscription.close();
              }
            }
          },
        );
  } catch (_) {
    // Already recorded into appNotificationsProvider by the controller;
    // the global result listener shows the appropriate dialog/snackbar.
  } finally {
    if (context.mounted) {
      ScaffoldMessenger.of(context).removeCurrentSnackBar();
    }
  }
}
