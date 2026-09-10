import 'package:flutter/material.dart';

import 'package:collection/collection.dart';
import 'package:data_pack/data_pack.dart';
import 'package:dm_file/dm_file.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:step_dialog/step_dialog.dart' as step_dialog;

import '../i18n/gen/strings.g.dart';
import '../providers/app_notification_providers.dart';
import '../providers/pending_operation_result_providers.dart';
import '../widgets/dialog/export_complete_dialog.dart';
import '../widgets/dialog/import_complete_dialog.dart';

/// [AppNotification.kind]s whose successful completion carries an
/// [ImportResult] in [pendingOperationResultProvider].
const _importResultKinds = {'cloud_backup_restore', 'dm_import'};

/// [AppNotification.kind]s whose successful completion carries an
/// [ExportResult] in [pendingOperationResultProvider].
const _exportResultKinds = {'cloud_backup_upload', 'dm_export'};

const _resultNotificationKinds = {..._importResultKinds, ..._exportResultKinds};

/// Reacts to every [AppNotification] kind reported by the four long-running
/// operations (cloud backup upload/restore, `.dm` export/import)
/// transitioning from `running` to a terminal status, and shows the
/// matching result/error dialog via [navigatorKey] — independent of
/// whichever page (if any) originally started the operation, so the result
/// still surfaces even if the user has since navigated elsewhere. Skips the
/// very first diff (app startup, [previous] is null) so a stale terminal
/// notification left over from a previous session is only cleaned up
/// silently, never displayed (its [pendingOperationResultProvider] payload
/// is long gone by then anyway, since that provider isn't persisted).
void handleAppNotificationTransitions(
  WidgetRef ref,
  GlobalKey<NavigatorState> navigatorKey,
  List<AppNotification>? previous,
  List<AppNotification> next,
) {
  for (final kind in _resultNotificationKinds) {
    final nextEntry = next.firstWhereOrNull((n) => n.kind == kind);
    if (nextEntry == null) continue;

    if (previous == null) {
      if (nextEntry.status != AppNotificationStatus.running) {
        ref.read(appNotificationsProvider.notifier).remove(kind);
      }
      continue;
    }

    final previousEntry = previous.firstWhereOrNull((n) => n.kind == kind);
    if (previousEntry?.status != AppNotificationStatus.running) continue;
    if (nextEntry.status == AppNotificationStatus.running) continue;

    _showResultForTransition(ref, navigatorKey, kind, nextEntry);
    ref.read(appNotificationsProvider.notifier).remove(kind);
  }
}

/// Shows the dialog or snack bar matching [entry]'s terminal [AppNotification.status].
void _showResultForTransition(
  WidgetRef ref,
  GlobalKey<NavigatorState> navigatorKey,
  String kind,
  AppNotification entry,
) {
  final context = navigatorKey.currentContext;
  switch (entry.status) {
    case AppNotificationStatus.completed:
      final result = ref
          .read(pendingOperationResultProvider.notifier)
          .take(kind);
      if (context == null) return;
      if (_importResultKinds.contains(kind) && result is ImportResult) {
        ImportCompleteDialog.show(context, result: result);
      } else if (_exportResultKinds.contains(kind) && result is ExportResult) {
        ExportCompleteDialog.show(context, result: result);
      }
    case AppNotificationStatus.cancelled:
      if (context == null) return;
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(t.cloudBackup.cancelled)));
    case AppNotificationStatus.failed:
      if (context == null) return;
      switch (entry.errorKind) {
        case 'not_signed_in':
          step_dialog.ErrorDialog.show(
            context,
            title: t.common.errorTitle,
            description: t.cloudBackup.notSignedInDescription,
          );
        case 'no_backup_found':
          step_dialog.ErrorDialog.show(
            context,
            title: t.common.errorTitle,
            description: t.cloudBackup.noBackupFoundDescription,
          );
        case 'dm_header_read_error':
          step_dialog.ErrorDialog.show(
            context,
            title: t.backup.importHeaderErrorTitle,
            description: t.backup.importHeaderErrorDescription,
          );
        case 'invalid_file':
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(t.home.importInvalidFile)));
        default:
          step_dialog.ErrorDialog.show(
            context,
            title: t.common.errorTitle,
            description: t.cloudBackup.networkErrorDescription(
              message: entry.message ?? '',
            ),
          );
      }
    case AppNotificationStatus.running:
      break;
  }
}
