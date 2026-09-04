import 'package:api_client/api_client.dart';
import 'package:denpamemo_widgets/denpamemo_widgets.dart'
    hide BuildContextTranslationsExtension;
import 'package:flutter/material.dart';

import '../../i18n/gen/strings.g.dart';

/// Shows [BottomSlideDialog] letting the user pick one [TableDefinition]
/// (a registered physique table type — HP, speed, evasion rate, ...
/// fetched from `GET /tables/types`, see `tableTypesProvider`). Mirrors
/// [showPhysiqueAntennaCategorySelectionDialog]'s shell: same shell, same
/// list-of-tiles content, just single-select over a flat list instead of
/// one grouped by a `category` field. When [dataAvailability] is given
/// (keyed by [TableDefinition.type]), each row shows a ○/✕ mark for
/// whether that type already has rows for the level/antenna category the
/// caller is picking within.
Future<TableDefinition?> showTableTypeSelectionDialog(
  BuildContext context, {
  required List<TableDefinition> types,
  TableDefinition? selected,
  Map<String, bool>? dataAvailability,
}) {
  return showBottomSlideDialog<TableDefinition>(
    context: context,
    builder: (context) => TableTypeSelectionDialog(
      types: types,
      initial: selected,
      dataAvailability: dataAvailability,
    ),
  );
}

class TableTypeSelectionDialog extends StatefulWidget {
  const TableTypeSelectionDialog({
    super.key,
    required this.types,
    this.initial,
    this.dataAvailability,
  });

  final List<TableDefinition> types;
  final TableDefinition? initial;
  final Map<String, bool>? dataAvailability;

  @override
  State<TableTypeSelectionDialog> createState() =>
      _TableTypeSelectionDialogState();
}

class _TableTypeSelectionDialogState extends State<TableTypeSelectionDialog> {
  late TableDefinition? _selected = widget.initial;

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
          for (final row in widget.types)
            ListTile(
              title: Text((t[row.translationKey] as String?) ?? row.type),
              selected: _selected?.type == row.type,
              trailing: _selected?.type == row.type
                  ? const Icon(Icons.check)
                  : switch (widget.dataAvailability?[row.type]) {
                      final hasData? => Icon(
                        hasData ? Icons.circle_outlined : Icons.close,
                      ),
                      null => null,
                    },
              onTap: () => setState(() => _selected = row),
            ),
        ],
      ),
    );
  }
}
