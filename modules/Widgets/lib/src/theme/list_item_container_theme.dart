// ignore_for_file: annotate_overrides

import 'package:flutter/material.dart';

import 'package:theme_tailor_annotation/theme_tailor_annotation.dart';

import 'tailor_config.dart';

part 'list_item_container_theme.tailor.dart';

/// Styling for [ListItemContainer]'s rounded grouping background, the
/// thin top/bottom border drawn by each [ListItemTile] inside it, a
/// [ListItemTile]'s selected-row tint, and the slide animation for its
/// checked indicator. Actual values are supplied by the app via
/// `ThemeData.extensions`.
@appTailorMixin
class ListItemContainerThemeData
    extends ThemeExtension<ListItemContainerThemeData>
    with _$ListItemContainerThemeDataTailorMixin {
  const ListItemContainerThemeData({
    required this.backgroundColor,
    required this.borderRadius,
    required this.tileBorderColor,
    required this.tileBorderWidth,
    required this.selectedBackgroundColor,
    required this.checkAnimationDuration,
    required this.checkAnimationInCurve,
    required this.checkAnimationOutCurve,
  });

  final Color backgroundColor;
  final double borderRadius;
  final Color tileBorderColor;
  final double tileBorderWidth;
  final Color selectedBackgroundColor;
  final Duration checkAnimationDuration;
  final Curve checkAnimationInCurve;
  final Curve checkAnimationOutCurve;
}
