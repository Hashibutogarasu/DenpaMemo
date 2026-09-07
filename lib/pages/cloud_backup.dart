import 'package:flutter/material.dart';

import 'package:data_pack/data_pack.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:graphql_client/graphql_client.dart';

import 'package:denpa_memo/widgets.dart';
import '../i18n/gen/strings.g.dart';
import '../providers/app_notification_providers.dart';
import '../providers/cloud_backup_restore_providers.dart';
import '../routing/app_router.dart';
import '../widgets/dialog/cloud_backup_flows.dart';
import '../widgets/scaffold/cloud_backup_shell.dart';

/// One tappable endpoint of the backup/restore flow: an icon over a label,
/// centered within the space it is given.
class _CloudBackupEndpoint extends StatelessWidget {
  const _CloudBackupEndpoint({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  final IconData icon;
  final String label;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 48),
            const SizedBox(height: 8),
            Text(label, style: Theme.of(context).textTheme.titleMedium),
          ],
        ),
      ),
    );
  }
}

/// Settings → cloud backup & restore: the top half backs up every
/// individual to R2 (tapping the cloud endpoint), the bottom half
/// downloads and restores the most recent cloud backup (tapping the local
/// endpoint), both via [runCloudBackup]/[runCloudRestore] in
/// `cloud_backup_flows.dart`. An [ArrowIcon] overlaid between the two
/// halves derives its direction/animation from [appNotificationsProvider].
class CloudBackupPage extends ConsumerWidget {
  const CloudBackupPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final t = context.t;
    final masterData = ref.watch(masterDataProvider).value;
    final restoreNotification = cloudBackupRestoreNotificationOf(
      ref.watch(appNotificationsProvider),
    );
    final isRestoring =
        restoreNotification?.status == AppNotificationStatus.running;
    final isBusy = ref.watch(cloudBackupBusyProvider);

    return AppScaffold(
      title: OutlinedTitleText(text: t.page.cloudBackup),
      belowHeader: const CloudBackupProgressBar(),
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
                child: masterData == null
                    ? _CloudBackupEndpoint(
                        icon: Icons.cloud_outlined,
                        label: t.cloudBackup.latestBackupLabel,
                        onTap: null,
                      )
                    : DisableWhileRunning(
                        provider: cloudBackupBusyProvider,
                        onPressed: () =>
                            runCloudBackup(context, ref, masterData),
                        builder: (context, onPressed) => _CloudBackupEndpoint(
                          icon: Icons.cloud_outlined,
                          label: t.cloudBackup.latestBackupLabel,
                          onTap: onPressed,
                        ),
                      ),
              ),
              Expanded(
                child: DisableWhileRunning(
                  provider: cloudBackupBusyProvider,
                  onPressed: () => runCloudRestore(context, ref),
                  builder: (context, onPressed) => _CloudBackupEndpoint(
                    icon: Icons.smartphone_outlined,
                    label: t.cloudBackup.localFileLabel,
                    onTap: onPressed,
                  ),
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
