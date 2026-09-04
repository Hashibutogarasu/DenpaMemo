import 'dart:io';

import 'package:denpamemo_widgets/denpamemo_widgets.dart'
    hide BuildContextTranslationsExtension;
import 'package:dm_file/dm_file.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/backup/dm_import_error.dart';
import '../../i18n/gen/strings.g.dart';
import '../../providers/denpa_men_icon_providers.dart';

/// Summarizes one `.dm` import's outcome as read-only sections. [show] is
/// the only sanctioned way to display this — it resolves every result
/// entry's icon via [resolveDenpaMenIcons] itself, so no caller can show
/// the dialog without that step (as opposed to a caller-supplied
/// `iconsById`, which each caller would have to remember on its own).
class ImportCompleteDialog extends StatelessWidget {
  const ImportCompleteDialog({super.key, required this.result, this.iconsById});

  final ImportResult result;

  /// Each added/merged/orphaned individual's already-resolved icon file,
  /// by [DenpaMen.id] — see [BackupResultSection.iconsById].
  final Map<String, File?>? iconsById;

  static Future<void> show(
    BuildContext context,
    WidgetRef ref, {
    required ImportResult result,
  }) async {
    final iconsById = await resolveDenpaMenIcons(
      (id) => ref.read(denpaMenIconProvider(id).future),
      [
        for (final denpaMen in [
          ...result.added,
          ...result.merged,
          ...result.orphaned,
        ])
          denpaMen.id,
      ],
    );
    if (!context.mounted) return;
    return showDialog<void>(
      context: context,
      builder: (context) =>
          ImportCompleteDialog(result: result, iconsById: iconsById),
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
                      iconsById: iconsById,
                    ),
                    BackupResultSection(
                      title: t.backup.importMergedSection,
                      denpaMens: result.merged,
                      iconsById: iconsById,
                    ),
                    BackupResultSection(
                      title: t.backup.importOrphanedSection,
                      denpaMens: result.orphaned,
                      iconsById: iconsById,
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
          itemBuilder: (context, index) => ListTile(
            title: Text(describeDenpaMenEntryParseError(t, failed[index])),
          ),
        ),
      ],
    );
  }
}
