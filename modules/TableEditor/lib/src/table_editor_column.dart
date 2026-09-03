/// One column of a [TableEditor]: how to read a row's display text, and,
/// when [editable], how to write edited text back via [onChanged]. Width
/// is measured by [TableEditor] itself. Text is the unit of exchange —
/// interpreting it numerically is entirely up to the caller.
class TableEditorColumn<T> {
  const TableEditorColumn({
    required this.key,
    required this.label,
    required this.valueOf,
    this.editable = false,
    this.onChanged,
  });

  final String key;
  final String label;
  final String Function(T row) valueOf;
  final bool editable;
  final void Function(T row, String value)? onChanged;
}
