// ignore_for_file: annotate_overrides

import 'package:flutter/material.dart';

import 'package:theme_tailor_annotation/theme_tailor_annotation.dart';

import 'tailor_config.dart';

part 'slanted_header_theme.tailor.dart';

/// Styling for [SlantedAppBar]'s diagonal-edge header: fill/border colors,
/// border thickness, slant angle, and the content row's padding. Actual
/// values are supplied by the app via `ThemeData.extensions`; this class
/// only defines what can be customized.
@appTailorMixin
class SlantedHeaderThemeData extends ThemeExtension<SlantedHeaderThemeData>
    with _$SlantedHeaderThemeDataTailorMixin {
  const SlantedHeaderThemeData({
    required this.fillColor,
    required this.borderColor,
    required this.borderWidth,
    required this.angleDegrees,
    required this.contentPadding,
  });

  final Color fillColor;
  final Color borderColor;
  final double borderWidth;
  final double angleDegrees;
  final EdgeInsetsGeometry contentPadding;
}
