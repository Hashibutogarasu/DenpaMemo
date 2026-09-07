import 'package:flutter/material.dart';

class AttributeIcon extends StatelessWidget {
  const AttributeIcon({super.key, this.icon, this.size = 20});

  final Widget? icon;
  final double size;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: const BoxDecoration(
        color: Colors.white,
        shape: BoxShape.circle,
      ),
      alignment: Alignment.center,
      child: icon,
    );
  }
}
