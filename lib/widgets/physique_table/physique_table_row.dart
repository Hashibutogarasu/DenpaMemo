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

  String valueAt(int columnIndex) => columnIndex < values.length ? values[columnIndex] : '';

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
/// `PhysiqueTableMetadata.physiqueTableColumnCount`).
List<TableEditorColumn<PhysiqueTableRow>> buildPhysiqueTableColumns({
  required int columnCount,
  void Function(int lineOffset, int columnIndex, String newValue)? onValueChanged,
}) {
  final columns = <TableEditorColumn<PhysiqueTableRow>>[];
  for (var i = 0; i < columnCount; i++) {
    final columnIndex = i;
    columns.add(
      TableEditorColumn<PhysiqueTableRow>(
        key: 'v$columnIndex',
        label: '${columnIndex + 1}',
        valueOf: (row) => row.valueAt(columnIndex),
        editable: onValueChanged != null,
        onChanged: onValueChanged == null
            ? null
            : (row, value) => onValueChanged(row.lineOffset, columnIndex, value),
      ),
    );
  }
  return columns;
}
