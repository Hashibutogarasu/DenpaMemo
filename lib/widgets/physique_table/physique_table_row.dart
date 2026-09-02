import 'package:flutter_table_plus/flutter_table_plus.dart';

/// Width of the `#` (row number) column built by [buildPhysiqueTableColumns].
const double physiqueTableLineColumnWidth = 48;

/// Minimum width for one of [buildPhysiqueTableColumns]'s value columns.
const double physiqueTableMinValueColumnWidth = 48;

/// One row of a physique table as displayed in [FlutterTablePlus]. Kept
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
/// Value columns are editable only when [editable] is true. [columnCount]
/// must come from the caller (see
/// `PhysiqueTableMetadata.physiqueTableColumnCount`); [valueColumnWidth]
/// should come from [physiqueTableValueColumnWidth].
Map<String, TablePlusColumn<PhysiqueTableRow>> buildPhysiqueTableColumns({
  required bool editable,
  required int columnCount,
  double valueColumnWidth = 100,
}) {
  final builder = TableColumnsBuilder<PhysiqueTableRow>()
    ..addColumn(
      'line',
      TablePlusColumn<PhysiqueTableRow>(
        key: 'line',
        label: '#',
        order: 0,
        width: physiqueTableLineColumnWidth,
        valueAccessor: (row) => row.lineOffset + 1,
      ),
    );
  for (var i = 0; i < columnCount; i++) {
    builder.addColumn(
      'v$i',
      TablePlusColumn<PhysiqueTableRow>(
        key: 'v$i',
        label: '${i + 1}',
        order: 0,
        editable: editable,
        width: valueColumnWidth,
        minWidth: physiqueTableMinValueColumnWidth,
        valueAccessor: (row) => row.values[i],
      ),
    );
  }
  return builder.build();
}

/// Value column width that fits [columnCount] columns into [availableWidth],
/// clamped to [physiqueTableMinValueColumnWidth] (past that point the table
/// scrolls horizontally instead of shrinking further).
double physiqueTableValueColumnWidth({
  required double availableWidth,
  required int columnCount,
}) {
  if (columnCount <= 0) return physiqueTableMinValueColumnWidth;
  final evenWidth = (availableWidth - physiqueTableLineColumnWidth) / columnCount;
  return evenWidth < physiqueTableMinValueColumnWidth
      ? physiqueTableMinValueColumnWidth
      : evenWidth;
}
