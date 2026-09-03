// ignore_for_file: annotate_overrides

import 'package:flutter/material.dart';
import 'package:theme_tailor_annotation/theme_tailor_annotation.dart';

import 'tailor_config.dart';

part 'app_dialog_theme.tailor.dart';

/// Open/close animation for [showBottomSlideDialog], which Flutter's
/// standard `ThemeData.dialogTheme` (shape/background) doesn't cover since
/// it's built on `showGeneralDialog` rather than `showDialog`. Actual
/// values are supplied by the app via `ThemeData.extensions`.
@appTailorMixin
class AppDialogThemeData extends ThemeExtension<AppDialogThemeData>
    with _$AppDialogThemeDataTailorMixin {
  const AppDialogThemeData({
    required this.transitionDuration,
    required this.transitionCurve,
    required this.reverseTransitionCurve,
    required this.barrierColor,
  });

  final Duration transitionDuration;
  final Curve transitionCurve;
  final Curve reverseTransitionCurve;
  final Color barrierColor;
}
