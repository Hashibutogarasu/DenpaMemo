import 'package:freezed_annotation/freezed_annotation.dart';

import 'app_theme_mode.dart';

part 'app_settings.freezed.dart';

/// App-wide settings that apply regardless of which [Account] is current.
@freezed
abstract class AppSettings with _$AppSettings {
  const factory AppSettings({
    @Default(AppThemeMode.system) AppThemeMode themeMode,
    @Default(false) bool buildTrackerEnabled,
  }) = _AppSettings;
}
