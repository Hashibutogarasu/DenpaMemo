import 'package:flutter/material.dart';

import '../theme/denpa_men_label_theme.dart';

/// Level-up progress bar with a square right edge and a slanted left edge
/// whose bottom corner juts out further left than its top corner. Fills
/// from the right as [value] increases.
class ExpBar extends StatelessWidget {
  const ExpBar({super.key, required this.value, this.minHeight = 12});

  final double value;
  final double minHeight;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).extension<DenpaMenLabelThemeData>()!;
    return SizedBox(
      height: minHeight,
      child: Stack(
        children: [
          ClipPath(
            clipper: _LeftSlantedClipper(),
            child: Stack(
              children: [
                SizedBox.expand(
                  child: ColoredBox(color: theme.expBarUnfilledColor),
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: FractionallySizedBox(
                    widthFactor: value.clamp(0, 1),
                    heightFactor: 1,
                    child: ColoredBox(color: theme.expBarFilledColor),
                  ),
                ),
              ],
            ),
          ),
          Positioned.fill(
            child: CustomPaint(
              painter: _LeftSlantedBorderPainter(
                borderColor: theme.expBarBorderColor,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

Path _slantedPath(Size size) {
  final slant = size.height * 0.6;
  return Path()
    ..moveTo(slant, 0)
    ..lineTo(size.width, 0)
    ..lineTo(size.width, size.height)
    ..lineTo(0, size.height)
    ..close();
}

class _LeftSlantedClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) => _slantedPath(size);

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}

class _LeftSlantedBorderPainter extends CustomPainter {
  _LeftSlantedBorderPainter({required this.borderColor});

  final Color borderColor;

  @override
  void paint(Canvas canvas, Size size) {
    canvas.drawPath(
      _slantedPath(size),
      Paint()
        ..color = borderColor
        ..style = PaintingStyle.stroke
        ..strokeWidth = 1.5,
    );
  }

  @override
  bool shouldRepaint(covariant _LeftSlantedBorderPainter oldDelegate) =>
      oldDelegate.borderColor != borderColor;
}
