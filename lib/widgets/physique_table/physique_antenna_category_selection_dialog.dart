import 'package:data_pack/data_pack.dart';
import 'package:denpamemo_widgets/denpamemo_widgets.dart' hide BuildContextTranslationsExtension;
import 'package:flutter/material.dart';

import '../../i18n/gen/strings.g.dart';

/// Shows [BottomSlideDialog] letting the user pick one
/// [PhysiqueAntennaCategory], grouped by its `category` field. Mirrors the
/// shape of the other `showXSelectionDialog` helpers in
/// `modules/Widgets/lib/src/dialog/` (e.g. `CorrectionSelectionDialog`)
/// rather than a bespoke dialog: same shell, same list-of-tiles content,
/// just single-select instead of multi-select.
Future<PhysiqueAntennaCategory?> showPhysiqueAntennaCategorySelectionDialog(
  BuildContext context, {
  required List<PhysiqueAntennaCategory> categories,
  PhysiqueAntennaCategory? selected,
}) {
  return showBottomSlideDialog<PhysiqueAntennaCategory>(
    context: context,
    builder: (context) => PhysiqueAntennaCategorySelectionDialog(
      categories: categories,
      initial: selected,
    ),
  );
}

class PhysiqueAntennaCategorySelectionDialog extends StatefulWidget {
  const PhysiqueAntennaCategorySelectionDialog({
    super.key,
    required this.categories,
    this.initial,
  });

  final List<PhysiqueAntennaCategory> categories;
  final PhysiqueAntennaCategory? initial;

  @override
  State<PhysiqueAntennaCategorySelectionDialog> createState() =>
      _PhysiqueAntennaCategorySelectionDialogState();
}

class _PhysiqueAntennaCategorySelectionDialogState
    extends State<PhysiqueAntennaCategorySelectionDialog> {
  late PhysiqueAntennaCategory? _selected = widget.initial;

  @override
  Widget build(BuildContext context) {
    final t = context.t;

    final byCategory = <String, List<PhysiqueAntennaCategory>>{};
    for (final row in widget.categories) {
      byCategory.putIfAbsent(row.category, () => []).add(row);
    }

    return BottomSlideDialog(
      title: t.physiqueTable.selectAnntenaCategory,
      confirmEnabled: _selected != null,
      onConfirm: () => Navigator.of(context).pop(_selected),
      content: ListView(
        shrinkWrap: true,
        children: [
          for (final entry in byCategory.entries) ...[
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              child: Text(entry.key, style: Theme.of(context).textTheme.labelSmall),
            ),
            for (final row in entry.value)
              ListTile(
                title: Text(row.anntenaCategory),
                selected: _selected?.anntenaCategory == row.anntenaCategory,
                trailing: _selected?.anntenaCategory == row.anntenaCategory
                    ? const Icon(Icons.check)
                    : null,
                onTap: () => setState(() => _selected = row),
              ),
          ],
        ],
      ),
    );
  }
}
