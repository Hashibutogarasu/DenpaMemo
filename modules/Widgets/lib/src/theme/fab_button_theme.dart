// ignore_for_file: annotate_overrides

import 'package:flutter/material.dart';
import 'package:theme_tailor_annotation/theme_tailor_annotation.dart';

import 'tailor_config.dart';

part 'fab_button_theme.tailor.dart';

/// Styling for an expandable FAB (main button + a stack of [MiniFabOption]s
/// revealed above it) and the dimmed, tap-to-dismiss backdrop shown while
/// it's expanded. Actual values are supplied by the app via
/// `ThemeData.extensions`; this class only defines what can be customized.
@appTailorMixin
class FabButtonThemeData extends ThemeExtension<FabButtonThemeData>
    with _$FabButtonThemeDataTailorMixin {
  const FabButtonThemeData({
    required this.barrierColor,
    required this.scrimAnimationDuration,
    required this.scrimAnimationCurve,
    required this.mainButtonAnimationDuration,
    required this.miniOptionSlideCurve,
    required this.miniOptionSlideOffset,
    required this.labelBubbleElevation,
    required this.labelBubbleBorderRadius,
    required this.labelBubblePadding,
    required this.miniOptionGap,
    required this.miniOptionRowBottomPadding,
  });

  /// Color of the full-screen scrim shown behind the expanded FAB while
  /// tapping outside of it is what dismisses it.
  final Color barrierColor;
  final Duration scrimAnimationDuration;
  final Curve scrimAnimationCurve;

  /// Default for [MiniFabOption]/the main FAB's own open/close animation;
  /// overridable per instance the same way [MiniFabOption.animationDuration]
  /// already is.
  final Duration mainButtonAnimationDuration;
  final Curve miniOptionSlideCurve;
  final Offset miniOptionSlideOffset;
  final double labelBubbleElevation;
  final double labelBubbleBorderRadius;
  final EdgeInsetsGeometry labelBubblePadding;
  final double miniOptionGap;
  final double miniOptionRowBottomPadding;
}
