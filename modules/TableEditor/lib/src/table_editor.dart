import 'package:flutter/material.dart';
import 'package:flutter_table_plus/flutter_table_plus.dart';

import 'table_editor_cell_field.dart';
import 'table_editor_column.dart';

/// Even width for [columnCount] columns filling [availableWidth] after
/// [reservedWidth] (e.g. any fixed-width leading column), clamped to
/// [minWidth] — past that point the table scrolls horizontally instead of
/// shrinking columns further.
double evenTableEditorColumnWidth({
  required double availableWidth,
  required int columnCount,
  double reservedWidth = 0,
  double minWidth = 48,
}) {
  if (columnCount <= 0) return minWidth;
  final evenWidth = (availableWidth - reservedWidth) / columnCount;
  return evenWidth < minWidth ? minWidth : evenWidth;
}

/// A [FlutterTablePlus] wrapper of rows of type [T], described by
/// [TableEditorColumn]s. Editable columns render as always-live
/// [TableEditorCellField]s rather than the underlying library's
/// tap-to-edit cells, wrapped in a [FocusTraversalGroup] so Tab moves
/// between them in reading order — this is the only place in the app that
/// needs to know how that navigation works.
class TableEditor<T> extends StatelessWidget {
  const TableEditor({
    super.key,
    required this.columns,
    required this.data,
    required this.rowId,
    this.isSelectable = false,
    this.selectionMode = SelectionMode.multiple,
    this.selectedRows = const <String>{},
    this.onCheckboxChanged,
  });

  final List<TableEditorColumn<T>> columns;
  final List<T> data;
  final String Function(T row) rowId;
  final bool isSelectable;
  final SelectionMode selectionMode;
  final Set<String> selectedRows;
  final void Function(String rowId, bool isSelected)? onCheckboxChanged;

  @override
  Widget build(BuildContext context) {
    final builder = TableColumnsBuilder<T>();
    for (final column in columns) {
      builder.addColumn(
        column.key,
        TablePlusColumn<T>(
          key: column.key,
          label: column.label,
          order: 0,
          width: column.width,
          minWidth: column.minWidth,
          valueAccessor: column.valueOf,
          statefulCellBuilder: column.editable && column.onChanged != null
              ? (context, rowData, isSelected, isDim) => TableEditorCellField(
                  key: ValueKey('${rowId(rowData)}:${column.key}'),
                  initialValue: column.valueOf(rowData),
                  onChanged: (value) => column.onChanged!(rowData, value),
                )
              : null,
        ),
      );
    }

    return FocusTraversalGroup(
      policy: ReadingOrderTraversalPolicy(),
      child: FlutterTablePlus<T>(
        columns: builder.build(),
        data: data,
        rowId: rowId,
        isSelectable: isSelectable,
        selectionMode: selectionMode,
        selectedRows: selectedRows,
        onCheckboxChanged: onCheckboxChanged,
      ),
    );
  }
}
