import 'package:flutter/material.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

import 'body_color_palette.dart';
import 'color_dot.dart';

@widgetbook.UseCase(name: 'Normal', type: ColorDot, path: 'color')
Widget colorDotNormalUseCase(BuildContext context) {
  return ColorDot(colorId: bodyColorPalette.keys.first);
}

@widgetbook.UseCase(name: 'Thin', type: ColorDot, path: 'color')
Widget colorDotThinUseCase(BuildContext context) {
  return ColorDot(colorId: bodyColorPalette.keys.first, shadeLevel: -1);
}

@widgetbook.UseCase(name: 'Dark', type: ColorDot, path: 'color')
Widget colorDotDarkUseCase(BuildContext context) {
  return ColorDot(colorId: bodyColorPalette.keys.first, shadeLevel: 1);
}

@widgetbook.UseCase(name: 'Unknown', type: ColorDot, path: 'color')
Widget colorDotUnknownUseCase(BuildContext context) {
  return const ColorDot(colorId: 'unknown');
}
