import 'package:flutter/material.dart';
import 'package:flutter_table_plus/flutter_table_plus.dart';

import 'table_editor_cell_field.dart';
import 'table_editor_column.dart';

/// A [FlutterTablePlus] wrapper of rows of type [T], described by
/// [TableEditorColumn]s. Editable columns render as always-live
/// [TableEditorCellField]s rather than the underlying library's
/// tap-to-edit cells, wrapped in a [FocusTraversalGroup] so Tab moves
/// between them in reading order. Column widths are measured from each
/// column's header label and actual row values via
/// [TableColumnWidthCalculator], floored at [kMinInteractiveDimension]
/// for editable columns so their [TableEditorCellField] stays a
/// comfortable tap/edit target even when its content is just one digit.
/// [trailingCellBuilder], when given, appends one fixed-width,
/// non-editable column after every data column — e.g. a per-row delete
/// button — sized by [trailingColumnWidth].
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
    this.trailingCellBuilder,
    this.trailingColumnWidth = 48.0,
  });

  final List<TableEditorColumn<T>> columns;
  final List<T> data;
  final String Function(T row) rowId;
  final bool isSelectable;
  final SelectionMode selectionMode;
  final Set<String> selectedRows;
  final void Function(String rowId, bool isSelected)? onCheckboxChanged;
  final Widget Function(T row)? trailingCellBuilder;
  final double trailingColumnWidth;

  @override
  Widget build(BuildContext context) {
    final headerStyle = DefaultTextStyle.of(context).style;
    final bodyStyle = DefaultTextStyle.of(context).style;

    final builder = TableColumnsBuilder<T>();
    for (final column in columns) {
      final isEditable = column.editable && column.onChanged != null;
      var width = TableColumnWidthCalculator.calculateColumnWidth<T>(
        headerLabel: column.label,
        headerTextStyle: headerStyle,
        data: data,
        valueAccessor: column.valueOf,
        bodyTextStyle: bodyStyle,
      );
      if (isEditable && width < kMinInteractiveDimension) {
        width = kMinInteractiveDimension;
      }
      builder.addColumn(
        column.key,
        TablePlusColumn<T>(
          key: column.key,
          label: column.label,
          order: 0,
          width: width,
          minWidth: width,
          valueAccessor: column.valueOf,
          statefulCellBuilder: isEditable
              ? (context, rowData, isSelected, isDim) => TableEditorCellField(
                  key: ValueKey('${rowId(rowData)}:${column.key}'),
                  initialValue: column.valueOf(rowData),
                  onChanged: (value) => column.onChanged!(rowData, value),
                )
              : null,
        ),
      );
    }

    if (trailingCellBuilder case final trailingCellBuilder?) {
      final trailingKey = GlobalKey().toString();
      builder.addColumn(
        trailingKey,
        TablePlusColumn<T>(
          key: trailingKey,
          label: '',
          order: columns.length,
          width: trailingColumnWidth,
          minWidth: trailingColumnWidth,
          valueAccessor: (row) => '',
          statefulCellBuilder: (context, rowData, isSelected, isDim) =>
              trailingCellBuilder(rowData),
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
