import 'package:flutter/material.dart';

import 'package:data_pack/data_pack.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:denpa_memo/widgets.dart' hide Translations;
import '../../i18n/gen/strings.g.dart';
import '../../providers/operation_progress_providers.dart';
import '../scaffold/cloud_backup_shell.dart';

/// Live status of whichever cloud backup upload/restore is currently
/// running, opened from the "i" info icon in `CloudBackupPage`'s and
/// `CloudBackupHistoryPage`'s headers. Unlike `ExportCompleteDialog`/
/// `ImportCompleteDialog` (a frozen result snapshot), this is a
/// [ConsumerWidget] watching [cloudBackupRunningNotificationProvider] and
/// [operationProgressProvider] live, so it keeps updating while it's open.
class OperationProgressDialog extends ConsumerWidget {
  const OperationProgressDialog({super.key});

  static Future<void> show(BuildContext context) {
    return AppDialog.show<void>(
      context: context,
      builder: (context) => const OperationProgressDialog(),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final t = context.t;
    final running = ref.watch(cloudBackupRunningNotificationProvider);
    final detail = running == null
        ? null
        : ref.watch(operationProgressProvider)[running.kind];

    return Dialog(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 520, maxHeight: 760),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 8),
              child: Text(
                t.cloudBackup.progressDialogTitle,
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ),
            Flexible(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: running == null
                    ? Padding(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        child: Text(t.cloudBackup.progressDialogIdle),
                      )
                    : Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            running.kind == 'cloud_backup_upload'
                                ? t.cloudBackup.backupRunning
                                : t.cloudBackup.restoreRunning,
                          ),
                          const SizedBox(height: 12),
                          LinearProgressIndicator(value: running.progress),
                          const SizedBox(height: 16),
                          Text(
                            detail?.currentIndividualName != null
                                ? t.cloudBackup.progressDialogCurrentIndividual(
                                    name: detail!.currentIndividualName!,
                                  )
                                : t.cloudBackup.progressDialogNoIndividual,
                          ),
                          const SizedBox(height: 8),
                          Text(_speedText(t, detail)),
                        ],
                      ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: SizedBox(
                width: double.infinity,
                child: FilledButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: Text(t.common.confirm),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _speedText(Translations t, OperationProgressDetail? detail) {
    final itemsPerSecond = detail?.itemsPerSecond;
    if (itemsPerSecond != null) {
      return t.cloudBackup.progressDialogItemsPerSecond(
        rate: itemsPerSecond.toStringAsFixed(1),
      );
    }
    final bytesPerSecond = detail?.bytesPerSecond;
    if (bytesPerSecond != null) {
      return t.cloudBackup.progressDialogBytesPerSecond(
        rate: _formatBytesPerSecond(bytesPerSecond),
      );
    }
    return t.cloudBackup.progressDialogMeasuring;
  }

  /// Formats [bytesPerSecond] as a human-readable rate (1024-based KB/MB
  /// stepping), e.g. `512.0B`, `3.4KB`, `1.2MB`.
  String _formatBytesPerSecond(double bytesPerSecond) {
    const units = ['B', 'KB', 'MB', 'GB'];
    var value = bytesPerSecond;
    var unitIndex = 0;
    while (value >= 1024 && unitIndex < units.length - 1) {
      value /= 1024;
      unitIndex++;
    }
    final decimals = unitIndex == 0 ? 0 : 1;
    return '${value.toStringAsFixed(decimals)}${units[unitIndex]}';
  }
}
