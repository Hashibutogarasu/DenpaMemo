// ignore_for_file: annotate_overrides

import 'package:flutter/material.dart';

import 'package:theme_tailor_annotation/theme_tailor_annotation.dart';

import 'tailor_config.dart';

part 'fab_label_theme.tailor.dart';

/// Whether text-labeled [FloatingActionButton]s that were converted to be
/// icon-only (e.g. [AppBackButton], the search trigger FAB) show their
/// label and/or a tooltip. Actual values are supplied by the app via
/// `ThemeData.extensions`.
@appTailorMixin
class FabLabelThemeData extends ThemeExtension<FabLabelThemeData>
    with _$FabLabelThemeDataTailorMixin {
  const FabLabelThemeData({required this.showLabel, required this.showTooltip});

  final bool showLabel;
  final bool showTooltip;
}
