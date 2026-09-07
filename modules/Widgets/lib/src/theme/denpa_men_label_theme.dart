// ignore_for_file: annotate_overrides

import 'package:flutter/material.dart';

import 'package:theme_tailor_annotation/theme_tailor_annotation.dart';

import 'tailor_config.dart';

part 'denpa_men_label_theme.tailor.dart';

/// Styling for the small label widgets used across denpa men stat displays:
/// [OutlinedTitleText]'s default outline, [StatValueLabel]/[AttributeLabel]'s
/// pill, [ExpBar], and the maxed/inactive-bonus highlight colors. Actual
/// values are supplied by the app via `ThemeData.extensions`.
@appTailorMixin
class DenpaMenLabelThemeData extends ThemeExtension<DenpaMenLabelThemeData>
    with _$DenpaMenLabelThemeDataTailorMixin {
  const DenpaMenLabelThemeData({
    required this.headerTitleOutlineColor,
    required this.pillBackgroundColor,
    required this.pillTextColor,
    required this.expBarFilledColor,
    required this.expBarUnfilledColor,
    required this.maxedValueColor,
    required this.inactiveBonusColor,
    required this.titleFillColor,
    required this.expBarBorderColor,
  });

  final Color headerTitleOutlineColor;
  final Color pillBackgroundColor;
  final Color pillTextColor;
  final Color expBarFilledColor;
  final Color expBarUnfilledColor;
  final Color maxedValueColor;
  final Color inactiveBonusColor;
  final Color titleFillColor;
  final Color expBarBorderColor;
}
