import 'dart:math' as math;

import 'package:flutter/material.dart';

/// Displays a single stat entry as a rounded label whose right edge is cut
/// at an angle (matching [StatusLabel]'s shape), with [value] rendered
/// outside the label rather than inside it. Both halves sit in their own
/// transparent container so the label's colored background never bleeds
/// into the value area.
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
    return Row(
      children: [
        Expanded(
          child: Container(
            color: Colors.transparent,
            child: ClipPath(
              clipper: _SlantedLabelClipper(),
              child: Container(
                height: height,
                color: const Color(0xFF7FC9FF),
                alignment: Alignment.centerLeft,
                padding: const EdgeInsets.only(left: 12, right: 18),
                child: DefaultTextStyle.merge(
                  style: const TextStyle(color: Color(0xFF2B2031)),
                  child: Text(label, overflow: TextOverflow.ellipsis),
                ),
              ),
            ),
          ),
        ),
        Expanded(
          child: Container(
            color: Colors.transparent,
            alignment: Alignment.centerLeft,
            padding: const EdgeInsets.only(left: 8),
            child: value,
          ),
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
