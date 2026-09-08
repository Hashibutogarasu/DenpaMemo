import 'package:flutter/animation.dart';

/// Shared design tokens (spacing, radius, border width, elevation,
/// animation, and Material 3 type-scale font sizes) used by
/// [AppCommonTheme]/`buildAppTheme` and by the app's own theme-extension
/// instantiations, so those values are named and reused instead of being
/// repeated as unexplained numeric literals.
abstract final class AppConstants {
  static const double spacingXs = 4;
  static const double spacingSm = 8;
  static const double spacingMd = 16;
  static const double spacingLg = 24;
  static const double spacingXl = 32;
  static const double spacingXxl = 48;

  static const double radiusXs = 4;
  static const double radiusSm = 8;
  static const double radiusMd = 12;
  static const double radiusLg = 20;
  static const double radiusXl = 24;
  static const double radiusFull = 9999;

  static const double borderWidthThin = 1;
  static const double borderWidthMedium = 2;
  static const double borderWidthThick = 4;

  static const double elevationLevel0 = 0;
  static const double elevationLevel1 = 1;
  static const double elevationLevel2 = 3;
  static const double elevationLevel3 = 4;
  static const double elevationLevel4 = 6;
  static const double elevationLevel5 = 8;

  static const Duration durationFast = Duration(milliseconds: 150);
  static const Duration durationNormal = Duration(milliseconds: 200);
  static const Duration durationSlow = Duration(milliseconds: 400);

  static const Curve curveStandard = Curves.easeOutCubic;
  static const Curve curveEmphasized = Curves.easeOutBack;
  static const Curve curveLinear = Curves.linear;

  static const double fontSizeDisplayLarge = 57;
  static const double fontSizeDisplayMedium = 45;
  static const double fontSizeDisplaySmall = 36;
  static const double fontSizeHeadlineLarge = 32;
  static const double fontSizeHeadlineMedium = 28;
  static const double fontSizeHeadlineSmall = 24;
  static const double fontSizeTitleLarge = 22;
  static const double fontSizeTitleMedium = 16;
  static const double fontSizeTitleSmall = 14;
  static const double fontSizeBodyLarge = 16;
  static const double fontSizeBodyMedium = 14;
  static const double fontSizeBodySmall = 12;
  static const double fontSizeLabelLarge = 14;
  static const double fontSizeLabelMedium = 12;
  static const double fontSizeLabelSmall = 11;
}
