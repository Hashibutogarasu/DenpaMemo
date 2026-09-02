import 'package:data_pack/data_pack.dart';
import 'package:dm_file/dm_file.dart';
import 'package:firebase_sign_in/firebase_sign_in.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:step_dialog/step_dialog.dart' show ErrorDialog;

import '../../i18n/gen/strings.g.dart';
import '../../providers/cancellation.dart';
import '../../providers/cloud_backup_restore_providers.dart';
import '../../providers/cloud_backup_upload_providers.dart';
import 'export_complete_dialog.dart';
import 'import_complete_dialog.dart';

void showCancellableSnackBar(BuildContext context, String message, VoidCallback onCancel) {
  final t = context.t;
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(message),
      duration: const Duration(minutes: 10),
      action: SnackBarAction(label: t.common.cancel, onPressed: onCancel),
    ),
  );
}

/// Runs [CloudBackupUploadController.upload] with a cancellable snackbar,
/// then shows [ExportCompleteDialog] on success or an error dialog/snackbar
/// per exception type. The only sanctioned way to start a backup upload,
/// so every entry point shows the same snackbar/progress/error handling.
Future<void> runCloudBackup(BuildContext context, WidgetRef ref, MasterData masterData) async {
  final t = context.t;
  final cancellation = Cancellation();
  showCancellableSnackBar(context, t.cloudBackup.backupRunning, cancellation.request);
  try {
    final result = await ref
        .read(cloudBackupUploadControllerProvider)
        .upload(masterData, cancellation: cancellation);
    if (!context.mounted) return;
    ScaffoldMessenger.of(context).removeCurrentSnackBar();
    await ExportCompleteDialog.show(context, ref, result: result);
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

/// Runs [CloudBackupRestoreController.restore] (restoring [target] if
/// given, otherwise the latest cloud backup) with a cancellable snackbar,
/// then shows [ImportCompleteDialog] on success or an error dialog/snackbar
/// per exception type. Shared by `CloudBackupPage`'s "restore latest"
/// endpoint and the backup history page's per-item "restore" action, so
/// both go through the exact same flow.
Future<void> runCloudRestore(BuildContext context, WidgetRef ref, {CloudFile? target}) async {
  final t = context.t;
  final cancellation = Cancellation();
  showCancellableSnackBar(context, t.cloudBackup.restoreRunning, cancellation.request);
  try {
    final result = await ref
        .read(cloudBackupRestoreControllerProvider)
        .restore(context, cancellation: cancellation, target: target);
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
