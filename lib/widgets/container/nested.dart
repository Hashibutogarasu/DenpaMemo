import 'package:flutter/material.dart';

class NestedContainer extends StatelessWidget {
  const NestedContainer({super.key, required this.child, this.padding});

  final Widget child;
  final EdgeInsetsGeometry? padding;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding ?? const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFFC8E0E7),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: const Color(0xFF90DAFE), width: 2),
      ),
      child: child,
    );
  }
}
