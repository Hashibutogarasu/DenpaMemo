/// One column of a [TableEditor]: how to read an integer value out of a
/// row of type [T], and — when [editable] is true — how to write an
/// edited value back via [onChanged]. Width is measured by [TableEditor]
/// itself, not specified here.
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
  final int Function(T row) valueOf;
  final bool editable;
  final void Function(T row, int value)? onChanged;
}
