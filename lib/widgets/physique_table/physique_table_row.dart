import 'package:denpamemo_widgets/denpamemo_widgets.dart';
import 'package:flutter/material.dart';
import 'package:table_editor/table_editor.dart';

/// One row of a physique table as displayed in [TableEditor]. Kept
/// immutable: edits are applied by building a new [PhysiqueTableRow] and
/// replacing it in the surrounding page's row list. Cells hold raw text
/// while being edited — parsing to an integer (and deciding what an
/// empty cell means, e.g. `0`) happens only once the row is persisted.
class PhysiqueTableRow {
  const PhysiqueTableRow({required this.lineOffset, required this.values});

  final int lineOffset;
  final List<String> values;

  String valueAt(int columnIndex) =>
      columnIndex < values.length ? values[columnIndex] : '';

  PhysiqueTableRow copyWithValueAt(int columnIndex, String value) {
    final updated = List<String>.of(values);
    while (updated.length <= columnIndex) {
      updated.add('');
    }
    updated[columnIndex] = value;
    return PhysiqueTableRow(lineOffset: lineOffset, values: updated);
  }
}

/// Builds one column per value column shared by the physique table's view
/// and edit pages, labelled by their 1-based index. Value columns are
/// editable only when [onValueChanged] is given, which is then called
/// with the row's `lineOffset`, the edited column's index, and the new
/// raw text. [columnCount] must come from the caller (see
/// `PhysiqueTableMetadata.physiqueTableColumnCount`). [isHighlighted],
/// when given (read-only tables only — it has no effect together with
/// [onValueChanged]), marks one `(lineOffset, columnIndex)` cell to be
/// drawn with `PhysiqueLegendGridThemeData`'s highlight border, dimming
/// every other cell — see the physique-identification "matching
/// location" page, which reuses this same column builder for its HP grid
/// rather than a bespoke one.
List<TableEditorColumn<PhysiqueTableRow>> buildPhysiqueTableColumns({
  required int columnCount,
  void Function(int lineOffset, int columnIndex, String newValue)?
  onValueChanged,
  bool Function(int lineOffset, int columnIndex)? isHighlighted,
}) {
  final columns = <TableEditorColumn<PhysiqueTableRow>>[];
  for (var i = 0; i < columnCount; i++) {
    final columnIndex = i;
    final isEditable = onValueChanged != null;
    columns.add(
      TableEditorColumn<PhysiqueTableRow>(
        key: 'v$columnIndex',
        label: '${columnIndex + 1}',
        valueOf: (row) => row.valueAt(columnIndex),
        editable: isEditable,
        onChanged: onValueChanged == null
            ? null
            : (row, value) =>
                  onValueChanged(row.lineOffset, columnIndex, value),
        cellBuilder: isEditable || isHighlighted == null
            ? null
            : (context, row) => _HighlightableTableCell(
                isHighlighted: isHighlighted(row.lineOffset, columnIndex),
                text: row.valueAt(columnIndex),
              ),
      ),
    );
  }
  return columns;
}

/// A read-only cell matching [TableEditor]'s default text styling, with
/// [PhysiqueLegendGridThemeData]'s highlight border applied when
/// [isHighlighted], and its dimmed background otherwise.
class _HighlightableTableCell extends StatelessWidget {
  const _HighlightableTableCell({
    required this.isHighlighted,
    required this.text,
  });

  final bool isHighlighted;
  final String text;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).extension<PhysiqueLegendGridThemeData>()!;
    return Container(
      width: double.infinity,
      alignment: Alignment.centerLeft,
      decoration: BoxDecoration(
        color: isHighlighted ? null : theme.dimmedBackgroundColor,
        border: isHighlighted
            ? Border.all(color: theme.highlightBorderColor, width: 2)
            : null,
      ),
      child: Text(
        text,
        style: DefaultTextStyle.of(context).style,
        maxLines: 1,
        softWrap: false,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }
}
