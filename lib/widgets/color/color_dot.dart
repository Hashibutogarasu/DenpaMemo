import 'package:flutter/material.dart';

import 'body_color_palette.dart';

/// Small round swatch for a body color id, used to preview the currently
/// selected body colors.
class ColorDot extends StatelessWidget {
  const ColorDot({super.key, required this.colorId});

  final String colorId;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 20,
      height: 20,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: bodyColorPalette[colorId],
        border: Border.all(color: Colors.black26),
      ),
    );
  }
}
