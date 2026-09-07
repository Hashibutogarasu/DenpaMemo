import 'package:flutter/material.dart';

/// Lays [level] and [happiness] side by side, [level] anchored to the
/// top-left and [happiness] to the top-right, shared by the editable and
/// read-only denpa-men status views so both stay visually consistent.
class GaugePairRow extends StatelessWidget {
  const GaugePairRow({super.key, required this.level, required this.happiness});

  final Widget level;
  final Widget happiness;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Align(alignment: Alignment.topLeft, child: level),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Align(alignment: Alignment.topRight, child: happiness),
        ),
      ],
    );
  }
}
