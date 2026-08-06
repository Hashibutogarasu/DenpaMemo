import 'package:flutter/material.dart';

/// Square, black-bordered, rounded icon slot used by abnormality resistance
/// entries (see [AbnormalityResistanceEntry]).
class AbnormalityIcon extends StatelessWidget {
  const AbnormalityIcon({super.key, this.icon, this.size = 20});

  final Widget? icon;
  final double size;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black, width: 1.5),
        borderRadius: BorderRadius.circular(6),
      ),
      alignment: Alignment.center,
      child: icon,
    );
  }
}
