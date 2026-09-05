import 'package:api_client/api_client.dart';
import 'package:flutter/material.dart';

/// Renders [sign] as the plus/minus icon shared by every place that shows
/// an `EvasionRateSign` (the physique-identification candidate dialog,
/// the "matching location" legend grid): a plus icon, a minus icon, or
/// nothing for `null`.
class EvasionRateSignIcon extends StatelessWidget {
  const EvasionRateSignIcon({required this.sign, this.size, super.key});

  final EvasionRateSign? sign;
  final double? size;

  @override
  Widget build(BuildContext context) {
    return switch (sign) {
      EvasionRateSign.plus => Icon(Icons.add, size: size),
      EvasionRateSign.minus => Icon(Icons.remove, size: size),
      null => const SizedBox.shrink(),
    };
  }
}
