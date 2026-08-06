import 'package:flutter/material.dart';

import '../field/inline_number_field.dart';
import 'status.dart';

/// A [StatusLabel] whose value is an inline-editable number, used for level
/// and happiness in [EditableDenpaMenStatus].
class InlineNumberStatusLabel extends StatelessWidget {
  const InlineNumberStatusLabel({
    super.key,
    required this.label,
    required this.value,
    required this.onChanged,
  });

  final String label;
  final int value;
  final ValueChanged<int> onChanged;

  @override
  Widget build(BuildContext context) {
    return StatusLabel(
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(label),
          const SizedBox(width: 4),
          SizedBox(
            width: 32,
            child: InlineNumberField(value: value, onChanged: onChanged),
          ),
        ],
      ),
    );
  }
}
