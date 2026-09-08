import 'package:flutter/material.dart';

import 'app_constants.dart';

/// Shortcuts for the [Theme]/[AppConstants] values every screen needs, so
/// call sites don't repeat `Theme.of(context)...` or hand-write spacing and
/// radius literals that already have a named [AppConstants] token.
extension AppThemeContextExtension on BuildContext {
  ThemeData get theme => Theme.of(this);

  ColorScheme get colorScheme => theme.colorScheme;

  TextTheme get textTheme => theme.textTheme;

  bool get isDarkMode => theme.brightness == Brightness.dark;

  SizedBox get gapXS =>
      const SizedBox.square(dimension: AppConstants.spacingXs);
  SizedBox get gapSM =>
      const SizedBox.square(dimension: AppConstants.spacingSm);
  SizedBox get gapMD =>
      const SizedBox.square(dimension: AppConstants.spacingMd);
  SizedBox get gapLG =>
      const SizedBox.square(dimension: AppConstants.spacingLg);
  SizedBox get gapXL =>
      const SizedBox.square(dimension: AppConstants.spacingXl);
  SizedBox get gapXXL =>
      const SizedBox.square(dimension: AppConstants.spacingXxl);

  EdgeInsets get paddingXS => const EdgeInsets.all(AppConstants.spacingXs);
  EdgeInsets get paddingSM => const EdgeInsets.all(AppConstants.spacingSm);
  EdgeInsets get paddingMD => const EdgeInsets.all(AppConstants.spacingMd);
  EdgeInsets get paddingLG => const EdgeInsets.all(AppConstants.spacingLg);
  EdgeInsets get paddingXL => const EdgeInsets.all(AppConstants.spacingXl);
  EdgeInsets get paddingXXL => const EdgeInsets.all(AppConstants.spacingXxl);

  BorderRadius get radiusXS => BorderRadius.circular(AppConstants.radiusXs);
  BorderRadius get radiusSM => BorderRadius.circular(AppConstants.radiusSm);
  BorderRadius get radiusMD => BorderRadius.circular(AppConstants.radiusMd);
  BorderRadius get radiusLG => BorderRadius.circular(AppConstants.radiusLg);
  BorderRadius get radiusXL => BorderRadius.circular(AppConstants.radiusXl);
  BorderRadius get radiusFull => BorderRadius.circular(AppConstants.radiusFull);
}
