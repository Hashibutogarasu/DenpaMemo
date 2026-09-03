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
/// Fill/border colors, border thickness, and content padding come from
/// [SlantedHeaderThemeData]; [borderWidth] lets a caller override the
/// theme's value for one instance, mirroring how other widgets in this
/// package let an explicit constructor argument win over the theme
/// default. [angleDegrees] is required rather than theme-resolved because
/// [preferredSize] (which depends on it) is read by [Scaffold] before
/// [build] runs, with no [BuildContext] available to look the theme up —
/// [AppScaffold], this widget's only caller, resolves
/// [SlantedHeaderThemeData.angleDegrees] itself and passes it down.
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
