import 'package:flutter/material.dart';

/// Displays [value] with an explicit "+" prefix for non-negative numbers;
/// negative numbers already carry their own "-" from [value]'s own sign.
class SignedNumberText extends StatelessWidget {
  const SignedNumberText({super.key, required this.value, this.style});

  final int value;
  final TextStyle? style;

  @override
  Widget build(BuildContext context) {
    return Text(value >= 0 ? '+$value' : '$value', style: style);
  }
}
