import 'package:flutter/material.dart';

import 'package:data_pack/data_pack.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:step_dialog/step_dialog.dart' show ErrorDialog;

import '../../i18n/gen/strings.g.dart';
import '../../providers/cloud_files_providers.dart';
import 'confirm_dialog.dart';

Future<void> _deleteOne(
  BuildContext context,
  WidgetRef ref,
  CloudFile cloudFile,
) async {
  final t = context.t;
  final confirmed = await ConfirmDialog.show(
    context,
    title: t.cloudBackup.deleteConfirmTitle,
    message: t.cloudBackup.deleteConfirmMessage,
  );
  if (!confirmed || !context.mounted) return;
  try {
    await ref
        .read(cloudFilesProvider.notifier)
        .deleteCloudFile(cloudFile.fileId);
  } catch (error, stackTrace) {
    if (!context.mounted) return;
    await ErrorDialog.show(
      context,
      title: t.common.errorTitle,
      description: t.cloudBackup.networkErrorDescription(message: '$error'),
      stackTrace: stackTrace,
    );
  }
}

/// The "restore"/"delete" menu shown from a backup history list item's `⋮`
/// trailing button. The restore entry is disabled when [onRestore] is
/// null — passed by the caller while a backup/restore is already running
/// elsewhere, since only one such operation can be in flight at a time.
List<PopupMenuEntry<VoidCallback>> cloudFileActionMenuItems(
  BuildContext context,
  WidgetRef ref, {
  required CloudFile cloudFile,
  required VoidCallback? onRestore,
}) {
  final t = context.t;
  return [
    PopupMenuItem(
      enabled: onRestore != null,
      value: onRestore ?? () {},
      child: Text(t.cloudBackup.restoreAction),
    ),
    PopupMenuItem(
      value: () => _deleteOne(context, ref, cloudFile),
      child: Text(t.common.delete),
    ),
  ];
}
