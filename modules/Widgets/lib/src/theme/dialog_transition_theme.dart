// ignore_for_file: annotate_overrides

import 'package:flutter/material.dart';

import 'package:theme_tailor_annotation/theme_tailor_annotation.dart';

import 'tailor_config.dart';

part 'dialog_transition_theme.tailor.dart';

/// Styling for [AppDialog.show]'s open/close transition: a slide combined
/// with a fade, driven by an animation running from 0 (closed) to 1 (open).
/// Actual values are supplied by the app via `ThemeData.extensions`.
@appTailorMixin
class DialogTransitionThemeData
    extends ThemeExtension<DialogTransitionThemeData>
    with _$DialogTransitionThemeDataTailorMixin {
  const DialogTransitionThemeData({
    required this.duration,
    required this.curve,
    required this.reverseCurve,
    required this.beginOffset,
  });

  final Duration duration;
  final Curve curve;
  final Curve reverseCurve;
  final Offset beginOffset;
}
