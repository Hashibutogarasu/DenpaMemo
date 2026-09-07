// ignore_for_file: annotate_overrides

import 'package:flutter/material.dart';

import 'package:theme_tailor_annotation/theme_tailor_annotation.dart';

import 'tailor_config.dart';

part 'physique_legend_grid_theme.tailor.dart';

/// Styling for the physique-identification "matching location" grid: the
/// border color used to highlight the one cell an identification search
/// actually matched, and the background color used to dim every other
/// cell. Actual values are supplied by the app via `ThemeData.extensions`.
@appTailorMixin
class PhysiqueLegendGridThemeData
    extends ThemeExtension<PhysiqueLegendGridThemeData>
    with _$PhysiqueLegendGridThemeDataTailorMixin {
  const PhysiqueLegendGridThemeData({
    required this.highlightBorderColor,
    required this.dimmedBackgroundColor,
  });

  final Color highlightBorderColor;
  final Color dimmedBackgroundColor;
}
