import 'package:flutter/material.dart';

/// A single editable numeric cell, rendered as an always-live [TextField]
/// so Tab can move between cells without a tap-to-edit step. Exchanges
/// raw text, not a parsed number, with the caller — an emptied cell is
/// passed through as `''` with no numeric coercion here.
class TableEditorCellField extends StatefulWidget {
  const TableEditorCellField({
    super.key,
    required this.initialValue,
    required this.onChanged,
  });

  final String initialValue;
  final ValueChanged<String> onChanged;

  @override
  State<TableEditorCellField> createState() => _TableEditorCellFieldState();
}

class _TableEditorCellFieldState extends State<TableEditorCellField> {
  late final TextEditingController _controller = TextEditingController(text: widget.initialValue);

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
      onChanged: widget.onChanged,
    );
  }
}
