import 'package:data_pack/data_pack.dart';
import 'package:flutter/material.dart';

import '../../i18n/gen/strings.g.dart';
import 'backup_result_section.dart';

/// Summarizes one `.dm` export's outcome as read-only sections, shown via
/// [show] after `_exportSelected` in `../../pages/home.dart` finishes.
/// Follows the same "public class + static show()" shape as
/// [DenpaMenPreviewDialog](denpa_men_preview_dialog.dart).
class ExportCompleteDialog extends StatelessWidget {
  const ExportCompleteDialog({super.key, required this.result});

  final ExportResult result;

  static Future<void> show(BuildContext context, {required ExportResult result}) {
    return showDialog<void>(
      context: context,
      builder: (context) => ExportCompleteDialog(result: result),
    );
  }

  @override
  Widget build(BuildContext context) {
    final t = context.t;
    return Dialog(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 520, maxHeight: 760),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 8),
              child: Text(
                t.backup.exportCompleteTitle,
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ),
            Flexible(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    BackupResultSection(
                      title: t.backup.exportExportedSection,
                      denpaMens: result.exported,
                    ),
                    BackupResultSection(
                      title: t.backup.exportOrphanedSection,
                      denpaMens: result.orphaned,
                    ),
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
}
