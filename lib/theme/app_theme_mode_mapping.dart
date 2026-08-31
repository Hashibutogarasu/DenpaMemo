import 'package:data_pack/data_pack.dart';
import 'package:flutter/material.dart';

/// Converts the domain [AppThemeMode] to Flutter's [ThemeMode].
extension AppThemeModeMapping on AppThemeMode {
  ThemeMode toFlutterThemeMode() {
    return switch (this) {
      AppThemeMode.system => ThemeMode.system,
      AppThemeMode.light => ThemeMode.light,
      AppThemeMode.dark => ThemeMode.dark,
    };
  }
}
