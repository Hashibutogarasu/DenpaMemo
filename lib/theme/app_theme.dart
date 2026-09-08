import 'package:flutter/material.dart';

import 'package:data_pack/data_pack.dart';
import 'package:denpamemo_widgets/denpamemo_widgets.dart';

import 'app_contrast_level_mapping.dart';

abstract final class AppLightTheme {
  static const _palette = AppPalette(
    settingsContainerLightnessDelta: -0.05,
    selectedItemLightnessDelta: -0.08,
    statusBackgroundColor: Color(0xFF90E2FF),
    nestedBorderColor: Color(0xFF90DAFE),
    expBarBorderColor: Colors.black,
    splashBackgroundColor: Color(0xFFF3EDF7),
    legendGridHighlightBorderColor: Color(0xFFE53935),
    legendGridDimmedBackgroundColor: Color(0x14000000),
    navigationBarTintColor: Color(0x80FFFFFF),
  );

  static final Map<AppContrastLevel, ThemeData> _themes = {
    for (final level in AppContrastLevel.values)
      level: buildAppTheme(
        Brightness.light,
        _palette,
        contrastLevel: level.toColorSchemeContrastLevel(),
      ),
  };

  static ThemeData forContrast(AppContrastLevel level) => _themes[level]!;
}

abstract final class AppDarkTheme {
  static const _palette = AppPalette(
    settingsContainerLightnessDelta: 0.12,
    selectedItemLightnessDelta: 0.12,
    statusBackgroundColor: Color(0xFF3E6E86),
    nestedBorderColor: Color(0xFF3B5F70),
    expBarBorderColor: Colors.white70,
    splashBackgroundColor: Color(0xFF1D1B20),
    legendGridHighlightBorderColor: Color(0xFFEF5350),
    legendGridDimmedBackgroundColor: Color(0x1FFFFFFF),
    navigationBarTintColor: Color(0x80000000),
  );

  static final Map<AppContrastLevel, ThemeData> _themes = {
    for (final level in AppContrastLevel.values)
      level: buildAppTheme(
        Brightness.dark,
        _palette,
        contrastLevel: level.toColorSchemeContrastLevel(),
      ),
  };

  static ThemeData forContrast(AppContrastLevel level) => _themes[level]!;
}
