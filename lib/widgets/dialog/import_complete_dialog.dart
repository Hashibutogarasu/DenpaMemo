import 'package:denpamemo_widgets/denpamemo_widgets.dart' hide BuildContextTranslationsExtension;
import 'package:flutter/material.dart';

import '../../domain/backup/dm_import_error.dart';
import '../../domain/backup/import_result.dart';
import '../../i18n/gen/strings.g.dart';

/// Summarizes one `.dm` import's outcome as read-only sections, shown via
/// [show] after `_importFromFile` in `../../pages/home.dart` finishes.
/// Follows the same "public class + static show()" shape as
/// [DenpaMenPreviewDialog](denpa_men_preview_dialog.dart).
class ImportCompleteDialog extends StatelessWidget {
  const ImportCompleteDialog({super.key, required this.result});

  final ImportResult result;

  static Future<void> show(BuildContext context, {required ImportResult result}) {
    return showDialog<void>(
      context: context,
      builder: (context) => ImportCompleteDialog(result: result),
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
                t.backup.importCompleteTitle,
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
                      title: t.backup.importAddedSection,
                      denpaMens: result.added,
                    ),
                    BackupResultSection(
                      title: t.backup.importMergedSection,
                      denpaMens: result.merged,
                    ),
                    BackupResultSection(
                      title: t.backup.importOrphanedSection,
                      denpaMens: result.orphaned,
                    ),
                    _FailedSection(failed: result.failed),
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

class _FailedSection extends StatelessWidget {
  const _FailedSection({required this.failed});

  final List<DenpaMenEntryParseError> failed;

  @override
  Widget build(BuildContext context) {
    if (failed.isEmpty) {
      return const SizedBox.shrink();
    }
    final t = context.t;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(12, 12, 12, 4),
          child: Text(
            '${t.backup.importFailedSection} (${failed.length})',
            style: Theme.of(context).textTheme.titleSmall,
          ),
        ),
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: failed.length,
          itemBuilder: (context, index) =>
              ListTile(title: Text(failed[index].description(t))),
        ),
      ],
    );
  }
}
