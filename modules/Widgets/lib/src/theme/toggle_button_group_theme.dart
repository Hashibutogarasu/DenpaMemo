// ignore_for_file: annotate_overrides

import 'package:flutter/material.dart';

import 'package:theme_tailor_annotation/theme_tailor_annotation.dart';

import 'tailor_config.dart';

part 'toggle_button_group_theme.tailor.dart';

/// Styling for [ToggleButtonGroup]: the outer pill's background/elevation,
/// the sliding highlight behind the selected segment, and the per-segment
/// icon colors and slide animation. Actual values are supplied by the app
/// via `ThemeData.extensions`.
@appTailorMixin
class ToggleButtonGroupThemeData
    extends ThemeExtension<ToggleButtonGroupThemeData>
    with _$ToggleButtonGroupThemeDataTailorMixin {
  const ToggleButtonGroupThemeData({
    required this.containerColor,
    required this.containerElevation,
    required this.containerBorderRadius,
    required this.highlightColor,
    required this.highlightBorderRadius,
    required this.selectedIconColor,
    required this.unselectedIconColor,
    required this.slideDuration,
    required this.slideCurve,
  });

  final Color containerColor;
  final double containerElevation;
  final double containerBorderRadius;
  final Color highlightColor;
  final double highlightBorderRadius;
  final Color selectedIconColor;
  final Color unselectedIconColor;
  final Duration slideDuration;
  final Curve slideCurve;
}
