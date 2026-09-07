// ignore_for_file: annotate_overrides

import 'package:flutter/material.dart';

import 'package:theme_tailor_annotation/theme_tailor_annotation.dart';

import 'tailor_config.dart';

part 'app_button_theme.tailor.dart';

/// Styling for [FilledButton]/[ElevatedButton]: a frosted-glass background
/// painted via [ButtonStyle.backgroundBuilder] instead of a flat
/// [ButtonStyle.backgroundColor]. Actual values are supplied by the app via
/// `ThemeData.extensions`.
@appTailorMixin
class AppButtonThemeData extends ThemeExtension<AppButtonThemeData>
    with _$AppButtonThemeDataTailorMixin {
  const AppButtonThemeData({
    required this.backgroundTintColor,
    required this.blurSigma,
    required this.foregroundColor,
  });

  final Color backgroundTintColor;
  final double blurSigma;
  final Color foregroundColor;
}
