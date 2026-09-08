import 'package:objectbox/objectbox.dart';

/// Persisted representation of the app's single
/// [AppSettings](../../../modules/DataPack/lib/src/settings/app_settings.dart)
/// row. `themeMode` stores an `AppThemeMode.name` value, `contrastLevel` an
/// `AppContrastLevel.name` value.
@Entity()
class AppSettingsEntity {
  @Id()
  int id;

  String themeMode;

  String contrastLevel;

  bool buildTrackerEnabled;

  AppSettingsEntity({
    this.id = 0,
    this.themeMode = 'system',
    this.contrastLevel = 'standard',
    this.buildTrackerEnabled = false,
  });
}
