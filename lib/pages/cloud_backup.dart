import 'package:flutter/material.dart';

import 'package:data_pack/data_pack.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:graphql_client/graphql_client.dart';

import 'package:denpa_memo/widgets.dart';
import '../i18n/gen/strings.g.dart';
import '../providers/active_cancellation_providers.dart';
import '../providers/app_notification_providers.dart';
import '../providers/cloud_backup_restore_providers.dart';
import '../routing/app_router.dart';
import '../widgets/dialog/cloud_backup_flows.dart';
import '../widgets/dialog/cloud_backup_progress_dialog.dart';
import '../widgets/scaffold/cloud_backup_shell.dart';

/// One half of the backup/restore flow: an icon and label (purely
/// decorative, not tappable) with an action button beneath it. The button
/// itself is the only tappable target — starts the operation while idle,
/// or requests cancellation (showing a spinner and switching its label)
/// while this endpoint's own operation is the one running.
class _CloudBackupEndpoint extends StatelessWidget {
  const _CloudBackupEndpoint({
    required this.icon,
    required this.label,
    required this.actionLabel,
    required this.isRunning,
    required this.onPressed,
  });

  final IconData icon;
  final String label;
  final String actionLabel;
  final bool isRunning;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    final t = context.t;
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 48),
          const SizedBox(height: 8),
          Text(label, style: Theme.of(context).textTheme.titleMedium),
          const SizedBox(height: 12),
          FilledButton(
            onPressed: onPressed,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (isRunning) ...[
                  const SizedBox(
                    width: 16,
                    height: 16,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  ),
                  const SizedBox(width: 8),
                ],
                Text(isRunning ? t.common.cancel : actionLabel),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/// Settings → cloud backup & restore: the top half backs up every
/// individual to R2 (tapping the upload button), the bottom half
/// downloads and restores the most recent cloud backup (tapping the
/// download button), both via [runCloudBackup]/[runCloudRestore] in
/// `cloud_backup_flows.dart`. Each button shows a spinner and switches to
/// a cancel action while its own operation is running, and is disabled
/// (without a cancel affordance) while the other operation is running. An
/// [ArrowIcon] overlaid between the two halves derives its
/// direction/animation from [appNotificationsProvider].
class CloudBackupPage extends ConsumerWidget {
  const CloudBackupPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final t = context.t;
    final masterData = ref.watch(masterDataProvider).value;
    final runningNotification = ref.watch(
      cloudBackupRunningNotificationProvider,
    );
    final isRestoring =
        cloudBackupRestoreNotificationOf(
          ref.watch(appNotificationsProvider),
        )?.status ==
        AppNotificationStatus.running;
    final isBusy = ref.watch(cloudBackupBusyProvider);

    final isUploading = runningNotification?.kind == 'cloud_backup_upload';
    final isDownloading = runningNotification?.kind == 'cloud_backup_restore';

    return AppScaffold(
      title: OutlinedTitleText(text: t.page.cloudBackup),
      belowHeader: const CloudBackupProgressBar(),
      actions: [
        IconButton(
          icon: const Icon(Icons.info_outline),
          tooltip: t.cloudBackup.progressDialogTooltip,
          onPressed: () => OperationProgressDialog.show(context),
        ),
      ],
      floatingActionButton: FloatingActionButton(
        heroTag: 'cloudBackupHistoryFab',
        tooltip: t.cloudBackup.historyAction,
        onPressed: () => const CloudBackupHistoryRoute().push(context),
        child: const Icon(Icons.history),
      ),
      body: Stack(
        children: [
          Column(
            children: [
              Expanded(
                child: _CloudBackupEndpoint(
                  icon: Icons.cloud_outlined,
                  label: t.cloudBackup.latestBackupLabel,
                  actionLabel: t.cloudBackup.uploadAction,
                  isRunning: isUploading,
                  onPressed: masterData == null
                      ? null
                      : isUploading
                      ? () => ref.read(activeCancellationProvider)?.request()
                      : isBusy
                      ? null
                      : () => runCloudBackup(context, ref, masterData),
                ),
              ),
              Expanded(
                child: _CloudBackupEndpoint(
                  icon: Icons.smartphone_outlined,
                  label: t.cloudBackup.localFileLabel,
                  actionLabel: t.cloudBackup.downloadAction,
                  isRunning: isDownloading,
                  onPressed: isDownloading
                      ? () => ref.read(activeCancellationProvider)?.request()
                      : isBusy
                      ? null
                      : () => runCloudRestore(context, ref),
                ),
              ),
            ],
          ),
          Positioned.fill(
            child: Center(
              child: ArrowIcon(
                direction: isRestoring
                    ? ArrowDirection.toLocal
                    : ArrowDirection.toCloud,
                isAnimating: isBusy,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
