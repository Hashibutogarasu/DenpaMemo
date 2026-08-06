import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'inline_text_field.dart';

/// An [InlineTextField] restricted to non-negative integers, invoking
/// [onChanged] only once the entered text parses to a valid value.
class InlineNumberField extends StatelessWidget {
  const InlineNumberField({
    super.key,
    required this.value,
    required this.onChanged,
    this.style,
    this.textAlign = TextAlign.start,
  });

  final int value;
  final ValueChanged<int> onChanged;
  final TextStyle? style;
  final TextAlign textAlign;

  @override
  Widget build(BuildContext context) {
    return InlineTextField(
      value: '$value',
      style: style,
      textAlign: textAlign,
      keyboardType: TextInputType.number,
      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
      onChanged: (text) {
        final parsed = int.tryParse(text);
        if (parsed != null) {
          onChanged(parsed);
        }
      },
    );
  }
}
