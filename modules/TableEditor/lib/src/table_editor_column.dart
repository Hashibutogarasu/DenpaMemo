import 'package:flutter/widgets.dart';

/// One column of a [TableEditor]: how to read a row's display text, and,
/// when [editable], how to write edited text back via [onChanged]. Width
/// is measured by [TableEditor] itself (from [valueOf], so it stays
/// accurate even when [cellBuilder] renders something other than plain
/// text). Text is the unit of exchange — interpreting it numerically is
/// entirely up to the caller. [cellBuilder], when given, replaces this
/// column's cell content (e.g. to add a highlight decoration around the
/// same text) without turning the column editable.
class TableEditorColumn<T> {
  const TableEditorColumn({
    required this.key,
    required this.label,
    required this.valueOf,
    this.editable = false,
    this.onChanged,
    this.cellBuilder,
  });

  final String key;
  final String label;
  final String Function(T row) valueOf;
  final bool editable;
  final void Function(T row, String value)? onChanged;
  final Widget Function(BuildContext context, T row)? cellBuilder;
}
