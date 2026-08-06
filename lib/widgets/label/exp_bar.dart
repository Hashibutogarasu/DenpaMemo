import 'package:flutter/material.dart';

import '../../theme/app_colors.dart';

/// Level-up progress bar with a square right edge and a slanted left edge
/// whose bottom corner juts out further left than its top corner, backed by
/// [AppColors.expBarBackground] with the filled portion in
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
    final slant = size.height * 0.6;
    return Path()
      ..moveTo(slant, 0)
      ..lineTo(size.width, 0)
      ..lineTo(size.width, size.height)
      ..lineTo(0, size.height)
      ..close();
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}
