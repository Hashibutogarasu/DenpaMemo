import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../theme/slanted_header_theme.dart';

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
///
/// Fill/border colors and content padding come from [SlantedHeaderThemeData].
/// [angleDegrees] is required rather than theme-resolved because
/// [preferredSize] is read by [Scaffold] before [build] runs, with no
/// [BuildContext] available — [AppScaffold] resolves it and passes it down.
class SlantedAppBar extends StatelessWidget implements PreferredSizeWidget {
  const SlantedAppBar({
    super.key,
    this.title,
    this.actions,
    required this.angleDegrees,
    this.height = 56,
    this.borderWidth,
    this.topSafeAreaInset = 0,
  });

  final Widget? title;
  final List<Widget>? actions;
  final double height;
  final double? borderWidth;
  final double angleDegrees;

  final double topSafeAreaInset;

  double get _contentHeight => height + topSafeAreaInset;

  double get _slant => height * math.tan(angleDegrees * math.pi / 180);

  @override
  Size get preferredSize => Size.fromHeight(_contentHeight + _slant);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).extension<SlantedHeaderThemeData>()!;
    final slant = _slant;
    return SizedBox(
      height: _contentHeight + slant,
      child: CustomPaint(
        painter: _SlantedHeaderPainter(
          slant: slant,
          fillColor: theme.fillColor,
          borderColor: theme.borderColor,
          borderWidth: borderWidth ?? theme.borderWidth,
        ),
        child: title == null && actions == null
            ? null
            : SafeArea(
                bottom: false,
                child: Padding(
                  padding: theme.contentPadding,
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
