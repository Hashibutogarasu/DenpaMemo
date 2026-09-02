import 'package:data_pack/data_pack.dart';
import 'package:denpamemo_widgets/denpamemo_widgets.dart' hide BuildContextTranslationsExtension;
import 'package:dm_file/dm_file.dart';
import 'package:firebase_sign_in/firebase_sign_in.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:graphql_client/graphql_client.dart';
import 'package:step_dialog/step_dialog.dart' show ErrorDialog;

import '../i18n/gen/strings.g.dart';
import '../providers/app_notification_providers.dart';
import '../providers/cancellation.dart';
import '../providers/cloud_backup_restore_providers.dart';
import '../providers/cloud_backup_upload_providers.dart';
import '../widgets/dialog/export_complete_dialog.dart';
import '../widgets/dialog/import_complete_dialog.dart';

void _showCancellableSnackBar(BuildContext context, String message, VoidCallback onCancel) {
  final t = context.t;
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(message),
      duration: const Duration(minutes: 10),
      action: SnackBarAction(label: t.common.cancel, onPressed: onCancel),
    ),
  );
}

Future<void> _backup(BuildContext context, WidgetRef ref, MasterData masterData) async {
  final t = context.t;
  final cancellation = Cancellation();
  _showCancellableSnackBar(context, t.cloudBackup.backupRunningMessage, cancellation.request);
  try {
    final result = await ref
        .read(cloudBackupUploadControllerProvider)
        .upload(masterData, cancellation: cancellation);
    if (context.mounted) {
      ScaffoldMessenger.of(context).removeCurrentSnackBar();
      await ExportCompleteDialog.show(context, ref, result: result);
    }
  } on CancelledException {
    if (!context.mounted) return;
    ScaffoldMessenger.of(context).removeCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(t.cloudBackup.cancelled)));
  } on NotSignedInException {
    if (!context.mounted) return;
    ScaffoldMessenger.of(context).removeCurrentSnackBar();
    await ErrorDialog.show(
      context,
      title: t.common.errorTitle,
      description: t.cloudBackup.notSignedInDescription,
    );
  } catch (error, stackTrace) {
    if (!context.mounted) return;
    ScaffoldMessenger.of(context).removeCurrentSnackBar();
    await ErrorDialog.show(
      context,
      title: t.common.errorTitle,
      description: t.cloudBackup.networkErrorDescription(message: '$error'),
      stackTrace: stackTrace,
    );
  }
}

Future<void> _restore(BuildContext context, WidgetRef ref) async {
  final t = context.t;
  final cancellation = Cancellation();
  _showCancellableSnackBar(context, t.cloudBackup.restoreRunningMessage, cancellation.request);
  try {
    final result = await ref
        .read(cloudBackupRestoreControllerProvider)
        .restore(context, cancellation: cancellation);
    if (!context.mounted) return;
    ScaffoldMessenger.of(context).removeCurrentSnackBar();
    if (result != null) {
      await ImportCompleteDialog.show(context, ref, result: result);
    }
  } on CancelledException {
    if (!context.mounted) return;
    ScaffoldMessenger.of(context).removeCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(t.cloudBackup.cancelled)));
  } on NotSignedInException {
    if (!context.mounted) return;
    ScaffoldMessenger.of(context).removeCurrentSnackBar();
    await ErrorDialog.show(
      context,
      title: t.common.errorTitle,
      description: t.cloudBackup.notSignedInDescription,
    );
  } on CloudBackupNotFoundException {
    if (!context.mounted) return;
    ScaffoldMessenger.of(context).removeCurrentSnackBar();
    await ErrorDialog.show(
      context,
      title: t.common.errorTitle,
      description: t.cloudBackup.noBackupFoundDescription,
    );
  } on DmHeaderReadError {
    if (!context.mounted) return;
    ScaffoldMessenger.of(context).removeCurrentSnackBar();
    await ErrorDialog.show(
      context,
      title: t.backup.importHeaderErrorTitle,
      description: t.backup.importHeaderErrorDescription,
    );
  } on DmInvalidImportFileException {
    if (!context.mounted) return;
    ScaffoldMessenger.of(context).removeCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(t.home.importInvalidFile)));
  } catch (error, stackTrace) {
    if (!context.mounted) return;
    ScaffoldMessenger.of(context).removeCurrentSnackBar();
    await ErrorDialog.show(
      context,
      title: t.common.errorTitle,
      description: t.cloudBackup.networkErrorDescription(message: '$error'),
      stackTrace: stackTrace,
    );
  }
}

/// One tappable endpoint of the backup/restore flow: an icon over a label,
/// centered within the space it is given.
class _CloudBackupEndpoint extends StatelessWidget {
  const _CloudBackupEndpoint({required this.icon, required this.label, required this.onTap});

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
/// endpoint). An [ArrowIcon] overlaid between the two halves, and a
/// [ProgressBar] overlaid at the bottom of the page, both derive their
/// state from [appNotificationsProvider] — the one shared notification
/// source — rather than anything local to this page.
class CloudBackupPage extends ConsumerWidget {
  const CloudBackupPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final t = context.t;
    final masterData = ref.watch(masterDataProvider).value;
    final notifications = ref.watch(appNotificationsProvider);
    final uploadNotification = cloudBackupUploadNotificationOf(notifications);
    final restoreNotification = cloudBackupRestoreNotificationOf(notifications);
    final isUploading = uploadNotification?.status == AppNotificationStatus.running;
    final isRestoring = restoreNotification?.status == AppNotificationStatus.running;
    final runningNotification = isUploading ? uploadNotification : (isRestoring ? restoreNotification : null);

    return AppScaffold(
      title: OutlinedTitleText(text: t.page.cloudBackup),
      body: Stack(
        children: [
          Column(
            children: [
              Expanded(
                child: _CloudBackupEndpoint(
                  icon: Icons.cloud_outlined,
                  label: t.cloudBackup.latestBackupLabel,
                  onTap: masterData == null
                      ? null
                      : () => _backup(context, ref, masterData),
                ),
              ),
              Expanded(
                child: _CloudBackupEndpoint(
                  icon: Icons.smartphone_outlined,
                  label: t.cloudBackup.localFileLabel,
                  onTap: () => _restore(context, ref),
                ),
              ),
            ],
          ),
          Positioned.fill(
            child: Center(
              child: ArrowIcon(
                direction: isRestoring ? ArrowDirection.toLocal : ArrowDirection.toCloud,
                isAnimating: isUploading || isRestoring,
              ),
            ),
          ),
          if (runningNotification != null)
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: LinearProgressIndicator(value: runningNotification.progress),
            ),
        ],
      ),
    );
  }
}
