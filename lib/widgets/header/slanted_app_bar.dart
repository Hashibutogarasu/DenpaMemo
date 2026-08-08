import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../../theme/app_colors.dart';

/// App-wide header whose bottom edge slants at [_angleDegrees]: higher on
/// the left, lower on the right. The top edge stays flush with the top of
/// the bar's own box, so nothing behind the bar shows through — only the
/// bottom edge grows taller as it moves right, which is why the bar's own
/// height (its "top part") is taller than a plain [AppBar].
///
/// The slant offset is derived from [_height] rather than the bar's width —
/// deriving it from width would make the offset (and therefore the bar's
/// required height) scale with window width, which blows up well past a
/// usable header height on a wide desktop window.
class SlantedAppBar extends StatelessWidget implements PreferredSizeWidget {
  const SlantedAppBar({super.key, this.title, this.actions});

  final Widget? title;
  final List<Widget>? actions;

  static const double _height = 56;
  static const double _borderWidth = 6;
  static const double _angleDegrees = 10;

  static double get _slant =>
      _height * math.tan(_angleDegrees * math.pi / 180);

  @override
  Size get preferredSize => Size.fromHeight(_height + _slant);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: preferredSize.height,
      child: CustomPaint(
        painter: _SlantedHeaderPainter(
          slant: _slant,
          fillColor: AppColors.headerBackground,
          borderColor: AppColors.headerBorder,
          borderWidth: _borderWidth,
        ),
        child: title == null && actions == null
            ? null
            : SafeArea(
                bottom: false,
                child: Padding(
                  padding: const EdgeInsets.only(left: 20, top: 8, right: 8),
                  child: Row(
                    children: [
                      if (title != null) Expanded(child: title!),
                      if (actions != null) ...actions!,
                    ],
                  ),
                ),
              ),
      ),
    );
  }
}

class _SlantedHeaderPainter extends CustomPainter {
  const _SlantedHeaderPainter({
    required this.slant,
    required this.fillColor,
    required this.borderColor,
    required this.borderWidth,
  });

  final double slant;
  final Color fillColor;
  final Color borderColor;
  final double borderWidth;

  @override
  void paint(Canvas canvas, Size size) {
    final path = Path()
      ..moveTo(0, 0)
      ..lineTo(size.width, 0)
      ..lineTo(size.width, size.height)
      ..lineTo(0, size.height - slant)
      ..close();

    canvas.drawPath(path, Paint()..color = fillColor);
    canvas.drawLine(
      Offset(0, size.height - slant),
      Offset(size.width, size.height),
      Paint()
        ..color = borderColor
        ..style = PaintingStyle.stroke
        ..strokeWidth = borderWidth,
    );
  }

  @override
  bool shouldRepaint(covariant _SlantedHeaderPainter oldDelegate) {
    return oldDelegate.slant != slant ||
        oldDelegate.fillColor != fillColor ||
        oldDelegate.borderColor != borderColor ||
        oldDelegate.borderWidth != borderWidth;
  }
}
