import 'package:flutter_table_plus/flutter_table_plus.dart';

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
/// physique table's view and edit pages, labelled by their 1-based index
/// (there is no established name for these columns). Value columns are
/// editable only when [editable] is true. [columnCount] defaults to the
/// value column count used by `PhysiqueTableEntity` on the server.
Map<String, TablePlusColumn<PhysiqueTableRow>> buildPhysiqueTableColumns({
  required bool editable,
  int columnCount = 10,
}) {
  final builder = TableColumnsBuilder<PhysiqueTableRow>()
    ..addColumn(
      'line',
      TablePlusColumn<PhysiqueTableRow>(
        key: 'line',
        label: '#',
        order: 0,
        width: 48,
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
        valueAccessor: (row) => row.values[i],
      ),
    );
  }
  return builder.build();
}
