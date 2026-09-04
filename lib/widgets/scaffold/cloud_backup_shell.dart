import 'package:data_pack/data_pack.dart';
import 'package:denpamemo_widgets/denpamemo_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../providers/app_notification_providers.dart';
import '../../providers/cloud_backup_restore_providers.dart';
import '../../providers/cloud_backup_upload_providers.dart';

/// Marks `CloudBackupPage` and `CloudBackupHistoryPage` (see
/// `CloudBackupShellRouteData` in `app_router.dart`) as [AlwaysPoppableShellScope],
/// since the branch is only ever reached by push, so its pages get a back
/// button even on the shell's own nested [Navigator] first entry.
class CloudBackupShell extends StatelessWidget {
  const CloudBackupShell({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) => AlwaysPoppableShellScope(child: child);
}

/// Whichever of the cloud backup upload/restore [AppNotification]s is
/// currently running, or null if neither is — the single source [CloudBackupProgressBar]
/// and every "disable while busy" check reads, instead of each re-deriving
/// it from [appNotificationsProvider].
final cloudBackupRunningNotificationProvider = Provider<AppNotification?>((
  ref,
) {
  final notifications = ref.watch(appNotificationsProvider);
  final uploadNotification = cloudBackupUploadNotificationOf(notifications);
  final restoreNotification = cloudBackupRestoreNotificationOf(notifications);
  return uploadNotification?.status == AppNotificationStatus.running
      ? uploadNotification
      : restoreNotification?.status == AppNotificationStatus.running
      ? restoreNotification
      : null;
});

/// Whether either cloud backup operation is currently running, for
/// `DisableWhileRunning.provider`.
final cloudBackupBusyProvider = Provider<bool>(
  (ref) => ref.watch(cloudBackupRunningNotificationProvider) != null,
);

/// Progress bar shared by `CloudBackupPage` and `CloudBackupHistoryPage`,
/// so the progress is visible regardless of which page's endpoint started
/// the operation. Passed as `AppScaffold.belowHeader` by each of the two
/// pages.
class CloudBackupProgressBar extends ConsumerWidget {
  const CloudBackupProgressBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final runningNotification = ref.watch(
      cloudBackupRunningNotificationProvider,
    );
    if (runningNotification == null) return const SizedBox.shrink();
    return LinearProgressIndicator(value: runningNotification.progress);
  }
}
