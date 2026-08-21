import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../../theme/app_colors.dart';

/// App-wide header whose bottom edge slants at [angleDegrees]: higher on
/// the left, lower on the right. The top edge stays flush with the top of
/// the bar's own box, so nothing behind the bar shows through — only the
/// bottom edge grows taller as it moves right, which is why the bar's own
/// height (its "top part") is taller than a plain [AppBar].
///
/// The slant offset is derived from [height] rather than the bar's width —
/// deriving it from width would make the offset (and therefore the bar's
/// required height) scale with window width, which blows up well past a
/// usable header height on a wide desktop window.
class SlantedAppBar extends StatelessWidget implements PreferredSizeWidget {
  const SlantedAppBar({
    super.key,
    this.title,
    this.actions,
    this.height = 56,
    this.borderWidth = 6,
    this.angleDegrees = 10,
    this.topSafeAreaInset = 0,
  });

  final Widget? title;
  final List<Widget>? actions;
  final double height;
  final double borderWidth;
  final double angleDegrees;

  /// Extra height reserved above [height] for the device's top safe area
  /// (status bar/notch), so [SafeArea] below has room to inset the content
  /// without shrinking the space actually available to [title]/[actions].
  /// Callers read this from `MediaQuery.paddingOf(context)` — [SlantedAppBar]
  /// itself can't, since [Scaffold] reads [preferredSize] before [build] runs.
  final double topSafeAreaInset;

  double get _contentHeight => height + topSafeAreaInset;

  double get _slant => height * math.tan(angleDegrees * math.pi / 180);

  @override
  Size get preferredSize => Size.fromHeight(_contentHeight + _slant);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: preferredSize.height,
      child: CustomPaint(
        painter: _SlantedHeaderPainter(
          slant: _slant,
          fillColor: AppColors.headerBackground,
          borderColor: AppColors.headerBorder,
          borderWidth: borderWidth,
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
                      ...?actions,
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
