import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../theme/app_colors.dart';

/// Displays a single stat entry as a container with a rounded label whose
/// right edge is cut at an angle (matching [StatusLabel]'s shape), with
/// [value] rendered outside the label, right-aligned within the container.
/// The label's bottom border spans the rest of the container's width —
/// starting past the label's rounded left edge, since running it under that
/// curve would look off, and continuing to the container's right edge.
class StatValueLabel extends StatelessWidget {
  const StatValueLabel({
    super.key,
    required this.label,
    required this.value,
    this.height = 26,
  });

  final String label;
  final Widget value;
  final double height;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          left: height / 2,
          right: 0,
          bottom: 0,
          child: Container(height: 2, color: AppColors.pillBackground),
        ),
        Row(
          children: [
            Expanded(
              child: ClipPath(
                clipper: _SlantedLabelClipper(),
                child: Container(
                  height: height,
                  color: AppColors.pillBackground,
                  alignment: Alignment.centerLeft,
                  padding: const EdgeInsets.only(left: 12, right: 18),
                  child: DefaultTextStyle.merge(
                    style: const TextStyle(color: AppColors.pillText),
                    child: Text(label, overflow: TextOverflow.ellipsis),
                  ),
                ),
              ),
            ),
            Expanded(
              child: Container(
                alignment: Alignment.centerRight,
                padding: const EdgeInsets.only(right: 8),
                child: value,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _SlantedLabelClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final radius = size.height / 2;
    final slant = size.height * 0.6;
    return Path()
      ..moveTo(radius, 0)
      ..lineTo(size.width, 0)
      ..lineTo(size.width - slant, size.height)
      ..lineTo(radius, size.height)
      ..arcTo(
        Rect.fromCircle(center: Offset(radius, radius), radius: radius),
        math.pi / 2,
        math.pi,
        false,
      )
      ..close();
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}
