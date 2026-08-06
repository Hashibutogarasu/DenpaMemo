import 'package:flutter/material.dart';

class AttributeLabel extends StatelessWidget {
  const AttributeLabel({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      decoration: BoxDecoration(
        color: const Color(0xFF7FC9FF),
        borderRadius: BorderRadius.circular(999),
      ),
      child: DefaultTextStyle.merge(
        style: const TextStyle(color: Color(0xFF2B2031)),
        child: child,
      ),
    );
  }
}
