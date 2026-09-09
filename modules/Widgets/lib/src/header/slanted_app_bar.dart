import 'dart:math' as math;

import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../state/header_content_link.dart';
import '../theme/slanted_header_theme.dart';

/// App-wide header whose bottom edge slants at [angleDegrees] — shorter on
/// the left, taller on the right — leaving a transparent corner there.
/// [AppScaffold] overlays it above the body in a [Stack] rather than as
/// `Scaffold.appBar`, reading scroll offset and body size via [headerContentLinkProvider].
class SlantedAppBar extends ConsumerWidget {
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

  /// The header's opaque content height (excluding the slanted overhang),
  /// computable without a [SlantedAppBar] instance. [AppScaffold] uses this
  /// to size the top padding it gives the scrollable body.
  static double contentHeightFor({
    required double height,
    required double topSafeAreaInset,
  }) {
    return height + topSafeAreaInset;
  }

  double get _contentHeight =>
      contentHeightFor(height: height, topSafeAreaInset: topSafeAreaInset);

  double get _slant => height * math.tan(angleDegrees * math.pi / 180);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context).extension<SlantedHeaderThemeData>()!;
    final slant = _slant;
    final link = ref.watch(headerContentLinkProvider);
    final scrolled = link.scrollOffset > 0;
    final bodyRenderBox =
        link.bodyKey.currentContext?.findRenderObject() as RenderBox?;
    final bodyWidth = bodyRenderBox != null && bodyRenderBox.hasSize
        ? bodyRenderBox.size.width
        : null;

    return DecoratedBox(
      decoration: BoxDecoration(
        boxShadow: scrolled
            ? [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.2),
                  blurRadius: 4,
                  offset: const Offset(0, 2),
                ),
              ]
            : const [],
      ),
      child: SizedBox(
        width: bodyWidth,
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
