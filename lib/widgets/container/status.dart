import 'package:flutter/material.dart';

class StatusContainer extends StatelessWidget {
  const StatusContainer({super.key, required this.child, this.padding});

  final Widget child;
  final EdgeInsetsGeometry? padding;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding ?? const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF90E2FF),
        borderRadius: BorderRadius.circular(20),
      ),
      child: child,
    );
  }
}
