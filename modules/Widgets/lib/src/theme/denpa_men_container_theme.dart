// ignore_for_file: annotate_overrides

import 'package:flutter/material.dart';

import 'package:theme_tailor_annotation/theme_tailor_annotation.dart';

import 'tailor_config.dart';

part 'denpa_men_container_theme.tailor.dart';

/// Styling shared by [EditableDenpaMenStatus], [DenpaMenStatus] (display
/// and edit-page preview), and [DenpaMenAccordionTile] — including that
/// accordion's own internal widgets. Actual values are supplied by the app
/// via `ThemeData.extensions`.
@appTailorMixin
class DenpaMenContainerThemeData
    extends ThemeExtension<DenpaMenContainerThemeData>
    with _$DenpaMenContainerThemeDataTailorMixin {
  const DenpaMenContainerThemeData({
    required this.statusBackgroundColor,
    required this.statusBorderRadius,
    required this.nestedBackgroundColor,
    required this.nestedBorderColor,
    required this.nestedBorderWidth,
    required this.nestedBorderRadius,
    required this.accentColor,
    required this.memoBackgroundColor,
    required this.memoBorderRadius,
    required this.headerDividerHeight,
    required this.pencilIconSize,
    required this.previewIconSize,
    required this.accordionIconSize,
    required this.accordionTitleFontSize,
    required this.accordionCheckboxSlotSize,
    required this.accordionAnimationDuration,
    required this.resistanceGap,
    required this.nameFieldFillColor,
  });

  final Color statusBackgroundColor;
  final double statusBorderRadius;
  final Color nestedBackgroundColor;
  final Color nestedBorderColor;
  final double nestedBorderWidth;
  final double nestedBorderRadius;
  final Color accentColor;
  final Color memoBackgroundColor;
  final double memoBorderRadius;
  final double headerDividerHeight;
  final double pencilIconSize;
  final double previewIconSize;
  final double accordionIconSize;
  final double accordionTitleFontSize;
  final double accordionCheckboxSlotSize;
  final Duration accordionAnimationDuration;
  final double resistanceGap;
  final Color nameFieldFillColor;
}
