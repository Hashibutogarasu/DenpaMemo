import 'dart:ui';

import 'package:flutter/material.dart';

/// Frosted-glass panel: blurs whatever is behind [child] and lays
/// [tintColor] over it before painting [child] on top. Entity-agnostic —
/// shared by button backgrounds and the bottom navigation bar background.
///
/// Always clips to its own bounds (rounded by [borderRadius] when given,
/// otherwise a plain rectangle) — [BackdropFilter] blurs everything behind
/// it in the current layer unless explicitly clipped, so skipping this
/// would blur the whole screen instead of just this panel.
class FrostedBlur extends StatelessWidget {
  const FrostedBlur({
    super.key,
    required this.sigma,
    required this.tintColor,
    this.borderRadius,
    required this.child,
  });

  final double sigma;
  final Color tintColor;
  final BorderRadius? borderRadius;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: borderRadius ?? BorderRadius.zero,
      child: Stack(
        fit: StackFit.passthrough,
        children: [
          Positioned.fill(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: sigma, sigmaY: sigma),
              child: ColoredBox(color: tintColor),
            ),
          ),
          child,
        ],
      ),
    );
  }
}
