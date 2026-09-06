// ignore_for_file: annotate_overrides

import 'package:flutter/material.dart';
import 'package:theme_tailor_annotation/theme_tailor_annotation.dart';

import 'tailor_config.dart';

part 'list_item_container_theme.tailor.dart';

/// Styling for [ListItemContainer]'s rounded grouping background and the
/// thin top/bottom border drawn by each [ListItemTile] inside it. Actual
/// values are supplied by the app via `ThemeData.extensions`.
@appTailorMixin
class ListItemContainerThemeData
    extends ThemeExtension<ListItemContainerThemeData>
    with _$ListItemContainerThemeDataTailorMixin {
  const ListItemContainerThemeData({
    required this.backgroundColor,
    required this.borderRadius,
    required this.tileBorderColor,
    required this.tileBorderWidth,
  });

  final Color backgroundColor;
  final double borderRadius;
  final Color tileBorderColor;
  final double tileBorderWidth;
}
