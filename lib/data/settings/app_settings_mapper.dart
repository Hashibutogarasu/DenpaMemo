import 'package:data_pack/data_pack.dart';

import 'app_settings_entity.dart';

/// Converts domain [AppSettings] to its persisted [AppSettingsEntity] form.
extension AppSettingsEntityMapper on AppSettings {
  AppSettingsEntity toEntity({int id = 0}) {
    return AppSettingsEntity(id: id, themeMode: themeMode.name);
  }
}

/// Rebuilds domain [AppSettings] from a persisted [AppSettingsEntity].
extension AppSettingsEntityToDomain on AppSettingsEntity {
  AppSettings toDomain() {
    return AppSettings(
      themeMode: AppThemeMode.values.byName(themeMode),
    );
  }
}
