import 'package:flutter/material.dart';

import '../icon/abnormality.dart';
import 'signed_number.dart';

/// Displays a single abnormality resistance entry: a square, black-bordered
/// icon, the abnormality name left-aligned, and its signed value right-
/// aligned. Unlike [AttributeLabel]-based entries this has no background.
class AbnormalityResistanceEntry extends StatelessWidget {
  const AbnormalityResistanceEntry({
    super.key,
    required this.label,
    required this.value,
  });

  final String label;
  final int value;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const AbnormalityIcon(),
        const SizedBox(width: 4),
        Expanded(child: Text(label, overflow: TextOverflow.ellipsis)),
        SignedNumberText(value: value),
      ],
    );
  }
}
