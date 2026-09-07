import 'package:flutter/material.dart';

import 'package:api_client/api_client.dart';

import 'package:denpa_memo/widgets.dart';
import '../../i18n/gen/strings.g.dart';

/// Shows an [AlertDialog] letting the user pick one [TableDefinition]
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
  return AppDialog.show<TableDefinition>(
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
    final selected = _selected;
    final selectedIndex = selected == null
        ? null
        : indexOfOrNull(widget.types, (row) => row.type == selected.type);

    return AlertDialog(
      title: Text(t.physiqueTable.selectStatusCategory),
      content: SizedBox(
        width: double.maxFinite,
        child: SingleChildScrollView(
          child: ListItemContainer(
            selectedIndex: selectedIndex,
            children: [
              for (final row in widget.types)
                ListItemTile(
                  label: (t[row.translationKey] as String?) ?? row.type,
                  trailing: _selected?.type == row.type
                      ? const SizedBox.shrink()
                      : switch (widget.dataAvailability?[row.type]) {
                          final hasData? => Icon(
                            hasData ? Icons.circle_outlined : Icons.close,
                          ),
                          null => const SizedBox.shrink(),
                        },
                  onTap: () => setState(() => _selected = row),
                ),
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
