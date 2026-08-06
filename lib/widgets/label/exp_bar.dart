import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../../theme/app_colors.dart';

/// Level-up progress bar with a slanted left edge and a rounded right edge,
/// backed by [AppColors.expBarBackground] with the filled portion in
/// [AppColors.expBarProgress].
class ExpBar extends StatelessWidget {
  const ExpBar({super.key, required this.value, this.minHeight = 12});

  final double value;
  final double minHeight;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: minHeight,
      child: ClipPath(
        clipper: _LeftSlantedClipper(),
        child: LinearProgressIndicator(
          value: value,
          minHeight: minHeight,
          backgroundColor: AppColors.expBarBackground,
          valueColor: const AlwaysStoppedAnimation(AppColors.expBarProgress),
        ),
      ),
    );
  }
}

class _LeftSlantedClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final radius = size.height / 2;
    final slant = size.height * 0.6;
    final rightCenter = Offset(size.width - radius, radius);
    return Path()
      ..moveTo(slant, 0)
      ..lineTo(size.width - radius, 0)
      ..arcTo(
        Rect.fromCircle(center: rightCenter, radius: radius),
        -math.pi / 2,
        math.pi,
        false,
      )
      ..lineTo(slant, size.height)
      ..close();
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}
