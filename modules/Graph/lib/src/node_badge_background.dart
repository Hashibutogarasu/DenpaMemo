import 'package:flutter/material.dart';

/// A plain white circle behind [child], used to keep a small overlaid
/// label legible against a photo icon.
class NodeBadgeBackground extends StatelessWidget {
  const NodeBadgeBackground({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 3, vertical: 1),
      decoration: const BoxDecoration(
        color: Colors.white,
        shape: BoxShape.circle,
      ),
      child: child,
    );
  }
}
