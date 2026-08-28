import 'package:flutter/material.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

import 'body_color_palette.dart';
import 'color_dot.dart';

@widgetbook.UseCase(name: 'Default', type: Map<String, Color>, path: 'color')
Widget bodyColorPaletteUseCase(BuildContext context) {
  return Wrap(
    spacing: 8,
    runSpacing: 8,
    children: [
      for (final colorId in bodyColorPalette.keys)
        Column(
          mainAxisSize: MainAxisSize.min,
          children: [ColorDot(colorId: colorId), Text(colorId)],
        ),
    ],
  );
}
