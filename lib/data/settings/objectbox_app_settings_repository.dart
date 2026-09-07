import 'package:data_pack/data_pack.dart';

import 'package:denpa_memo/objectbox.g.dart';
import '../objectbox/objectbox.dart';
import 'app_settings_entity.dart';
import 'app_settings_mapper.dart';

/// [AppSettingsRepository] backed by the single row in the
/// [AppSettingsEntity] ObjectBox box.
class ObjectBoxAppSettingsRepository implements AppSettingsRepository {
  ObjectBoxAppSettingsRepository(this._objectBox);

  final ObjectBox _objectBox;

  Box<AppSettingsEntity> get _box => _objectBox.settingsBox;

  AppSettingsEntity get _row => _box.getAll().first;

  @override
  AppSettings get() => _row.toDomain();

  @override
  void save(AppSettings settings) {
    _box.put(settings.toEntity(id: _row.id));
  }
}
