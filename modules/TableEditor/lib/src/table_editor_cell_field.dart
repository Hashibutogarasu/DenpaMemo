import 'package:flutter/material.dart';

/// A single editable numeric cell. Always rendered as a live [TextField]
/// (not a tap-to-edit cell): keeping every cell permanently focusable is
/// what lets the platform's default focus traversal move between cells on
/// Tab, without [TableEditor] having to implement that itself.
class TableEditorCellField extends StatefulWidget {
  const TableEditorCellField({
    super.key,
    required this.initialValue,
    required this.onChanged,
  });

  final int initialValue;
  final ValueChanged<int> onChanged;

  @override
  State<TableEditorCellField> createState() => _TableEditorCellFieldState();
}

class _TableEditorCellFieldState extends State<TableEditorCellField> {
  late final TextEditingController _controller = TextEditingController(
    text: widget.initialValue.toString(),
  );

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: _controller,
      keyboardType: TextInputType.number,
      decoration: const InputDecoration(isDense: true, border: InputBorder.none),
      onChanged: (text) {
        final parsed = int.tryParse(text);
        if (parsed != null) widget.onChanged(parsed);
      },
    );
  }
}
