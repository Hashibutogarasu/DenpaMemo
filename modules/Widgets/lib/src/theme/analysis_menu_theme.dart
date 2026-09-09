// ignore_for_file: annotate_overrides

import 'package:flutter/material.dart';

import 'package:theme_tailor_annotation/theme_tailor_annotation.dart';

import 'tailor_config.dart';

part 'analysis_menu_theme.tailor.dart';

/// Styling for [AnalysisMenu]'s square, rounded-rectangle grid cells: the
/// cell background/foreground colors, corner radius, column count, item
/// spacing, inner content padding and icon size. Actual values are supplied
/// by the app via `ThemeData.extensions`.
@appTailorMixin
class AnalysisMenuThemeData extends ThemeExtension<AnalysisMenuThemeData>
    with _$AnalysisMenuThemeDataTailorMixin {
  const AnalysisMenuThemeData({
    required this.backgroundColor,
    required this.foregroundColor,
    required this.borderRadius,
    required this.columns,
    required this.spacing,
    required this.padding,
    required this.iconSize,
  });

  final Color backgroundColor;
  final Color foregroundColor;
  final double borderRadius;
  final int columns;
  final double spacing;
  final EdgeInsetsGeometry padding;
  final double iconSize;
}
