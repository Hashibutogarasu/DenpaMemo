import 'app_settings.dart';

/// Persists the single, app-wide [AppSettings] row.
///
/// Implementations must guarantee the row exists once constructed, so
/// [get] never has to represent absence.
abstract class AppSettingsRepository {
  AppSettings get();

  void save(AppSettings settings);
}
