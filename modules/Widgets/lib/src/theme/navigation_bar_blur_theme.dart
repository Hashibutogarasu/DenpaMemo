// ignore_for_file: annotate_overrides

import 'package:flutter/material.dart';

import 'package:theme_tailor_annotation/theme_tailor_annotation.dart';

import 'tailor_config.dart';

part 'navigation_bar_blur_theme.tailor.dart';

/// Styling for [AppBottomNavigationBar]'s frosted-glass background. Actual
/// values are supplied by the app via `ThemeData.extensions` — the tint
/// color differs between the light and dark theme instances rather than
/// being computed from [Brightness] at runtime.
@appTailorMixin
class NavigationBarBlurThemeData
    extends ThemeExtension<NavigationBarBlurThemeData>
    with _$NavigationBarBlurThemeDataTailorMixin {
  const NavigationBarBlurThemeData({
    required this.tintColor,
    required this.blurSigma,
  });

  final Color tintColor;
  final double blurSigma;
}
