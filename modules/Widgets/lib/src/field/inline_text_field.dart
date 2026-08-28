import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// A text field rendered without a border or underline, so it reads as
/// inline, always-editable text rather than a form control.
class InlineTextField extends StatefulWidget {
  const InlineTextField({
    super.key,
    required this.value,
    required this.onChanged,
    this.style,
    this.textAlign = TextAlign.start,
    this.keyboardType,
    this.inputFormatters,
    this.multiline = false,
  });

  final String value;
  final ValueChanged<String> onChanged;
  final TextStyle? style;
  final TextAlign textAlign;
  final TextInputType? keyboardType;
  final List<TextInputFormatter>? inputFormatters;

  /// Whether the field grows to fit wrapped text across multiple lines
  /// instead of staying a single line.
  final bool multiline;

  @override
  State<InlineTextField> createState() => _InlineTextFieldState();
}

class _InlineTextFieldState extends State<InlineTextField> {
  late final TextEditingController _controller = TextEditingController(
    text: widget.value,
  );

  @override
  void didUpdateWidget(covariant InlineTextField oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.value != oldWidget.value && widget.value != _controller.text) {
      _controller.text = widget.value;
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: _controller,
      style: widget.style,
      textAlign: widget.textAlign,
      keyboardType: widget.keyboardType,
      inputFormatters: widget.inputFormatters,
      maxLines: widget.multiline ? null : 1,
      minLines: widget.multiline ? 3 : null,
      decoration: const InputDecoration(
        border: InputBorder.none,
        enabledBorder: InputBorder.none,
        focusedBorder: InputBorder.none,
        isDense: true,
        contentPadding: EdgeInsets.zero,
      ),
      onChanged: widget.onChanged,
    );
  }
}
