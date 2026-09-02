import 'dart:io';

import 'package:data_pack/data_pack.dart';
import 'package:denpamemo_widgets/denpamemo_widgets.dart' hide BuildContextTranslationsExtension;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../i18n/gen/strings.g.dart';
import '../../providers/denpa_men_icon_providers.dart';

/// Summarizes one `.dm` export's outcome as read-only sections. [show] is
/// the only sanctioned way to display this — it resolves every result
/// entry's icon via [resolveDenpaMenIcons] itself, so no caller can show
/// the dialog without that step. Follows the same "public class + static
/// show()" shape as `ImportCompleteDialog`.
class ExportCompleteDialog extends StatelessWidget {
  const ExportCompleteDialog({super.key, required this.result, this.iconsById});

  final ExportResult result;

  /// Each exported/orphaned individual's already-resolved icon file, by
  /// [DenpaMen.id] — see [BackupResultSection.iconsById].
  final Map<String, File?>? iconsById;

  static Future<void> show(
    BuildContext context,
    WidgetRef ref, {
    required ExportResult result,
  }) async {
    final iconsById = await resolveDenpaMenIcons(ref, [
      for (final denpaMen in [...result.exported, ...result.orphaned]) denpaMen.id,
    ]);
    if (!context.mounted) return;
    return showDialog<void>(
      context: context,
      builder: (context) => ExportCompleteDialog(result: result, iconsById: iconsById),
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
                      iconsById: iconsById,
                    ),
                    BackupResultSection(
                      title: t.backup.exportOrphanedSection,
                      denpaMens: result.orphaned,
                      iconsById: iconsById,
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
