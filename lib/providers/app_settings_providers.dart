import 'package:data_pack/data_pack.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/settings/objectbox_app_settings_repository.dart';
import 'objectbox_providers.dart';

final appSettingsRepositoryProvider = Provider<AppSettingsRepository>((ref) {
  return ObjectBoxAppSettingsRepository(ref.watch(objectBoxProvider));
});

final appSettingsProvider = Provider<AppSettings>((ref) {
  return ref.watch(appSettingsRepositoryProvider).get();
});
