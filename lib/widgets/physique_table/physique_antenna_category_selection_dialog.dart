import 'package:flutter/material.dart';

import 'package:data_pack/data_pack.dart';
import 'package:denpamemo_widgets/denpamemo_widgets.dart'
    hide BuildContextTranslationsExtension;

import '../../i18n/gen/strings.g.dart';

/// Shows an [AlertDialog] letting the user pick one
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
  return showDialog<PhysiqueAntennaCategory>(
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

    return AlertDialog(
      title: Text(t.physiqueTable.selectAnntenaCategory),
      content: SizedBox(
        width: double.maxFinite,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              for (final entry in byCategory.entries) ...[
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  child: Text(
                    entry.key,
                    style: Theme.of(context).textTheme.labelSmall,
                  ),
                ),
                ListItemContainer(
                  selectedIndex: indexOfOrNull(
                    entry.value,
                    (row) => row.anntenaCategory == _selected?.anntenaCategory,
                  ),
                  children: [
                    for (final row in entry.value)
                      ListItemTile(
                        label: row.anntenaCategory,
                        trailing: const SizedBox.shrink(),
                        onTap: () => setState(() => _selected = row),
                      ),
                  ],
                ),
              ],
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text(t.common.cancel),
        ),
        FilledButton(
          onPressed: _selected == null
              ? null
              : () => Navigator.of(context).pop(_selected),
          child: Text(t.common.confirm),
        ),
      ],
    );
  }
}
