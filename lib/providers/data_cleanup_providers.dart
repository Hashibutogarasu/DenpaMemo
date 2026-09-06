import 'package:data_cache/data_cache.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/clipping/clipping_render.dart';
import '../data/settings/app_settings_entity.dart';
import 'account_scoped_paths_providers.dart';
import 'objectbox_providers.dart';

/// Drives the "data management" page's housekeeping actions: wiping the
/// account's persistent app directory and its ObjectBox data outright, and
/// wiping the temporary/cache directory.
class DataCleanupController {
  const DataCleanupController(this._ref);

  final Ref _ref;

  /// Deletes the account's persistent app directory outright, and clears
  /// every ObjectBox box that holds user data. The account record itself
  /// is left untouched, since account scoping — and therefore this very
  /// directory's path — depends on it.
  Future<void> deleteAllAppData() async {
    final appDirectory = await _ref.read(
      accountScopedAppDirectoryProvider.future,
    );
    if (await appDirectory.exists()) {
      await appDirectory.delete(recursive: true);
    }
    final objectBox = _ref.read(objectBoxProvider);
    objectBox.denpaMenBox.removeAll();
    objectBox.qrCodeBox.removeAll();
    objectBox.settingsBox.removeAll();
    objectBox.settingsBox.put(AppSettingsEntity());
  }

  /// Wipes the account's temporary/cache directory, every entry in the
  /// offline data cache, and every cached clipped-icon render, then bumps
  /// [cacheGenerationProvider] so anything reading through the cache
  /// invalidates itself.
  Future<void> clearCache() async {
    final tempDirectory = await _ref.read(
      accountScopedTempDirectoryProvider.future,
    );
    if (await tempDirectory.exists()) {
      await tempDirectory.delete(recursive: true);
    }
    await _ref.read(dataCacheProvider).clearAll();
    await clippedImageCacheManager.emptyCache();
    _ref.read(cacheGenerationProvider.notifier).state++;
  }
}

final dataCleanupControllerProvider = Provider<DataCleanupController>(
  (ref) => DataCleanupController(ref),
);
