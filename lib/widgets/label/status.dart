import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../../theme/app_colors.dart';

class StatusLabel extends StatelessWidget {
  const StatusLabel({super.key, required this.child, this.height = 30});

  final Widget child;
  final double height;

  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: _StatusLabelClipper(),
      child: Container(
        height: height,
        color: AppColors.statusBackground,
        alignment: Alignment.center,
        padding: const EdgeInsets.only(left: 14, right: 20),
        child: DefaultTextStyle.merge(
          style: const TextStyle(color: AppColors.accent),
          child: child,
        ),
      ),
    );
  }
}

class _StatusLabelClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final radius = size.height / 2;
    final slant = size.height * 0.6;
    return Path()
      ..moveTo(radius, 0)
      ..lineTo(size.width - slant, 0)
      ..lineTo(size.width, size.height)
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
