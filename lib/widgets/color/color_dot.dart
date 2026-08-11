import 'package:flutter/material.dart';

import 'body_color_palette.dart';

/// Lightens (negative) or darkens (positive) [color] by 10% per shade step.
Color shadeBodyColor(Color color, int shadeLevel) {
  if (shadeLevel < 0) {
    return Color.lerp(color, Colors.white, -shadeLevel * 0.1)!;
  }
  if (shadeLevel > 0) {
    return Color.lerp(color, Colors.black, shadeLevel * 0.1)!;
  }
  return color;
}

/// Small round swatch for a body color id, used to preview the currently
/// selected body colors.
class ColorDot extends StatelessWidget {
  const ColorDot({super.key, required this.colorId, this.shadeLevel = 0});

  final String colorId;
  final int shadeLevel;

  @override
  Widget build(BuildContext context) {
    final color = bodyColorPalette[colorId];

    return Container(
      width: 20,
      height: 20,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: color == null ? null : shadeBodyColor(color, shadeLevel),
        border: Border.all(color: Colors.black26),
      ),
    );
  }
}
