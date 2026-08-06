import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'inline_text_field.dart';

/// An [InlineTextField] restricted to non-negative integers, like
/// [InlineNumberField] but treating an emptied field as `null` instead of
/// leaving the last valid value in place.
class InlineNullableNumberField extends StatelessWidget {
  const InlineNullableNumberField({
    super.key,
    required this.value,
    required this.onChanged,
    this.style,
    this.textAlign = TextAlign.start,
  });

  final int? value;
  final ValueChanged<int?> onChanged;
  final TextStyle? style;
  final TextAlign textAlign;

  @override
  Widget build(BuildContext context) {
    return InlineTextField(
      value: value == null ? '' : '$value',
      style: style,
      textAlign: textAlign,
      keyboardType: TextInputType.number,
      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
      onChanged: (text) {
        if (text.isEmpty) {
          onChanged(null);
          return;
        }
        final parsed = int.tryParse(text);
        if (parsed != null) {
          onChanged(parsed);
        }
      },
    );
  }
}
