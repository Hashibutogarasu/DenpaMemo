import 'package:flutter/material.dart';

/// A single diagonal line styled like a Material [Icon], used as a plain
/// "/" separator — neither Material Icons nor this project's bundled
/// Lucide set has one.
class SlashIcon extends StatelessWidget {
  const SlashIcon({super.key, this.size = 24, this.color});

  final double size;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    final effectiveColor =
        color ??
        IconTheme.of(context).color ??
        Theme.of(context).colorScheme.onSurface;
    return CustomPaint(
      size: Size(size * 0.5, size),
      painter: _SlashPainter(color: effectiveColor, strokeWidth: size * 0.08),
    );
  }
}

class _SlashPainter extends CustomPainter {
  _SlashPainter({required this.color, required this.strokeWidth});

  final Color color;
  final double strokeWidth;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;
    canvas.drawLine(Offset(size.width, 0), Offset(0, size.height), paint);
  }

  @override
  bool shouldRepaint(covariant _SlashPainter oldDelegate) =>
      oldDelegate.color != color || oldDelegate.strokeWidth != strokeWidth;
}
