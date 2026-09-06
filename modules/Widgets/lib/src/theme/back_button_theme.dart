// ignore_for_file: annotate_overrides

import 'package:flutter/material.dart';
import 'package:theme_tailor_annotation/theme_tailor_annotation.dart';

import 'tailor_config.dart';

part 'back_button_theme.tailor.dart';

/// Which corner of [AppScaffold]'s body [Stack] [AppBackButton] (and any
/// `backButtonExtras`) is anchored to.
enum BackButtonAnchor {
  topLeft,
  topRight,
  bottomLeft,
  bottomRight;

  bool get isTop => this == topLeft || this == topRight;

  bool get isLeft => this == topLeft || this == bottomLeft;
}

/// Styling for where [AppScaffold] anchors [AppBackButton]. Actual values
/// are supplied by the app via `ThemeData.extensions`.
@appTailorMixin
class BackButtonThemeData extends ThemeExtension<BackButtonThemeData>
    with _$BackButtonThemeDataTailorMixin {
  const BackButtonThemeData({required this.anchor});

  final BackButtonAnchor anchor;
}
