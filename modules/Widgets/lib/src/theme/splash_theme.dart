// ignore_for_file: annotate_overrides

import 'package:flutter/material.dart';

import 'package:theme_tailor_annotation/theme_tailor_annotation.dart';

import 'tailor_config.dart';

part 'splash_theme.tailor.dart';

/// Styling for the app's startup splash ([LogoContainer] plus its
/// full-screen host): background color, the app name text size, and the
/// fade-out duration once the app signals it's ready to reveal the main
/// screen. Actual values are supplied by the app via `ThemeData.extensions`,
/// with [backgroundColor] set independently for the light and dark
/// `ThemeData`.
@appTailorMixin
class SplashThemeData extends ThemeExtension<SplashThemeData>
    with _$SplashThemeDataTailorMixin {
  const SplashThemeData({
    required this.backgroundColor,
    required this.appNameFontSize,
    required this.fadeOutDuration,
  });

  /// Baseline splash configuration shared by every `ThemeData`. Each theme
  /// derives its own [SplashThemeData] from this via [copyWith], overriding
  /// only [backgroundColor], instead of restating the shared field values.
  static const SplashThemeData defaults = SplashThemeData(
    backgroundColor: Color(0xFFFFFFFF),
    appNameFontSize: 34,
    fadeOutDuration: Duration(milliseconds: 400),
  );

  final Color backgroundColor;
  final double appNameFontSize;
  final Duration fadeOutDuration;
}
