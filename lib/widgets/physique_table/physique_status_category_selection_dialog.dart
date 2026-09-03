import 'package:data_pack/data_pack.dart';
import 'package:denpamemo_widgets/denpamemo_widgets.dart' hide BuildContextTranslationsExtension;
import 'package:flutter/material.dart';

import '../../i18n/gen/strings.g.dart';

/// Shows [BottomSlideDialog] letting the user pick one
/// [PhysiqueStatusCategory]. Mirrors
/// [showPhysiqueAntennaCategorySelectionDialog]'s shell: same shell, same
/// list-of-tiles content, just single-select over a flat list instead of
/// one grouped by a `category` field.
Future<PhysiqueStatusCategory?> showPhysiqueStatusCategorySelectionDialog(
  BuildContext context, {
  required List<PhysiqueStatusCategory> statusCategories,
  PhysiqueStatusCategory? selected,
}) {
  return showBottomSlideDialog<PhysiqueStatusCategory>(
    context: context,
    builder: (context) => PhysiqueStatusCategorySelectionDialog(
      statusCategories: statusCategories,
      initial: selected,
    ),
  );
}

class PhysiqueStatusCategorySelectionDialog extends StatefulWidget {
  const PhysiqueStatusCategorySelectionDialog({
    super.key,
    required this.statusCategories,
    this.initial,
  });

  final List<PhysiqueStatusCategory> statusCategories;
  final PhysiqueStatusCategory? initial;

  @override
  State<PhysiqueStatusCategorySelectionDialog> createState() =>
      _PhysiqueStatusCategorySelectionDialogState();
}

class _PhysiqueStatusCategorySelectionDialogState
    extends State<PhysiqueStatusCategorySelectionDialog> {
  late PhysiqueStatusCategory? _selected = widget.initial;

  @override
  Widget build(BuildContext context) {
    final t = context.t;

    return BottomSlideDialog(
      title: t.physiqueTable.selectStatusCategory,
      confirmEnabled: _selected != null,
      onConfirm: () => Navigator.of(context).pop(_selected),
      content: ListView(
        shrinkWrap: true,
        children: [
          for (final row in widget.statusCategories)
            ListTile(
              title: Text(row.name),
              selected: _selected?.name == row.name,
              trailing: _selected?.name == row.name ? const Icon(Icons.check) : null,
              onTap: () => setState(() => _selected = row),
            ),
        ],
      ),
    );
  }
}
