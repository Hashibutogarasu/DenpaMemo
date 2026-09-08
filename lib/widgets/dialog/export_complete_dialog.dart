import 'package:flutter/material.dart';

import 'package:data_pack/data_pack.dart';

import 'package:denpa_memo/widgets.dart';
import '../../i18n/gen/strings.g.dart';
import '../icon/denpa_men_list_tile_cell.dart';

/// Summarizes one `.dm` export's outcome as read-only sections. Each row
/// resolves its own icon reactively via [DenpaMenListTileCell] — see
/// `ImportCompleteDialog`'s doc comment, which this follows the same
/// "public class + static show()" shape as.
class ExportCompleteDialog extends StatelessWidget {
  const ExportCompleteDialog({super.key, required this.result});

  final ExportResult result;

  static Future<void> show(
    BuildContext context, {
    required ExportResult result,
  }) {
    return AppDialog.show<void>(
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
                      tileBuilder: (context, denpaMen) =>
                          DenpaMenListTileCell(denpaMen: denpaMen),
                    ),
                    BackupResultSection(
                      title: t.backup.exportOrphanedSection,
                      denpaMens: result.orphaned,
                      tileBuilder: (context, denpaMen) =>
                          DenpaMenListTileCell(denpaMen: denpaMen),
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
