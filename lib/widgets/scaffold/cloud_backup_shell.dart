import 'package:data_pack/data_pack.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../providers/app_notification_providers.dart';
import '../../providers/cloud_backup_restore_providers.dart';
import '../../providers/cloud_backup_upload_providers.dart';

/// Wraps `CloudBackupPage` and `CloudBackupHistoryPage` (see
/// `CloudBackupShellRouteData` in `app_router.dart`) with a progress bar
/// tracking whichever cloud backup/restore [AppNotification] is currently
/// running, so the progress is visible regardless of which page's
/// endpoint started the operation.
class CloudBackupShell extends ConsumerWidget {
  const CloudBackupShell({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notifications = ref.watch(appNotificationsProvider);
    final uploadNotification = cloudBackupUploadNotificationOf(notifications);
    final restoreNotification = cloudBackupRestoreNotificationOf(notifications);
    final runningNotification = uploadNotification?.status == AppNotificationStatus.running
        ? uploadNotification
        : restoreNotification?.status == AppNotificationStatus.running
        ? restoreNotification
        : null;

    return Stack(
      children: [
        child,
        if (runningNotification != null)
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: LinearProgressIndicator(value: runningNotification.progress),
          ),
      ],
    );
  }
}
