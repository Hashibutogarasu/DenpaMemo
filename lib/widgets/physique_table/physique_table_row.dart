import 'package:table_editor/table_editor.dart';

/// Width of the `#` (row number) column built by [buildPhysiqueTableColumns].
const double physiqueTableLineColumnWidth = 48;

/// Minimum width for one of [buildPhysiqueTableColumns]'s value columns.
const double physiqueTableMinValueColumnWidth = 48;

/// One row of a physique table as displayed in [TableEditor]. Kept
/// immutable: edits are applied by building a new [PhysiqueTableRow] and
/// replacing it in the surrounding page's row list.
class PhysiqueTableRow {
  const PhysiqueTableRow({required this.lineOffset, required this.values});

  final int lineOffset;
  final List<int> values;

  PhysiqueTableRow copyWithValueAt(int columnIndex, int value) {
    final updated = List<int>.of(values);
    updated[columnIndex] = value;
    return PhysiqueTableRow(lineOffset: lineOffset, values: updated);
  }
}

/// Builds the `#` (row number) + one column per value column shared by the
/// physique table's view and edit pages, labelled by their 1-based index.
/// Value columns are editable only when [onValueChanged] is given, which is
/// then called with the row's `lineOffset`, the edited column's index, and
/// the new value. [columnCount] must come from the caller (see
/// `PhysiqueTableMetadata.physiqueTableColumnCount`); [valueColumnWidth]
/// should come from [physiqueTableValueColumnWidth].
List<TableEditorColumn<PhysiqueTableRow>> buildPhysiqueTableColumns({
  required int columnCount,
  double valueColumnWidth = 100,
  void Function(int lineOffset, int columnIndex, int newValue)? onValueChanged,
}) {
  final columns = <TableEditorColumn<PhysiqueTableRow>>[
    TableEditorColumn<PhysiqueTableRow>(
      key: 'line',
      label: '#',
      valueOf: (row) => row.lineOffset + 1,
      width: physiqueTableLineColumnWidth,
    ),
  ];
  for (var i = 0; i < columnCount; i++) {
    final columnIndex = i;
    columns.add(
      TableEditorColumn<PhysiqueTableRow>(
        key: 'v$columnIndex',
        label: '${columnIndex + 1}',
        valueOf: (row) => row.values[columnIndex],
        editable: onValueChanged != null,
        onChanged: onValueChanged == null
            ? null
            : (row, value) => onValueChanged(row.lineOffset, columnIndex, value),
        width: valueColumnWidth,
        minWidth: physiqueTableMinValueColumnWidth,
      ),
    );
  }
  return columns;
}

/// Value column width that fits [columnCount] columns into [availableWidth],
/// clamped to [physiqueTableMinValueColumnWidth] (past that point the table
/// scrolls horizontally instead of shrinking further).
double physiqueTableValueColumnWidth({
  required double availableWidth,
  required int columnCount,
}) {
  return evenTableEditorColumnWidth(
    availableWidth: availableWidth,
    columnCount: columnCount,
    reservedWidth: physiqueTableLineColumnWidth,
    minWidth: physiqueTableMinValueColumnWidth,
  );
}
