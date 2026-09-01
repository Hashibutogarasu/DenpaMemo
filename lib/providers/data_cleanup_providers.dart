import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/settings/app_settings_entity.dart';
import 'account_scoped_paths_providers.dart';
import 'objectbox_providers.dart';

/// Drives the "data management" page's housekeeping actions: wiping the
/// account's persistent app directory and its ObjectBox data outright, and
/// wiping the temporary/cache directory.
class DataCleanupController {
  const DataCleanupController(this._ref);

  final Ref _ref;

  /// Deletes every file under the account's persistent app directory
  /// (icons, and anything else stored there), and clears every ObjectBox
  /// box that holds user data (denpa men, QR codes, settings). The account
  /// record itself is left untouched, since account scoping — and
  /// therefore this very directory's path — depends on it.
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

  /// Wipes the account's temporary/cache directory. Safe to call anytime,
  /// since it is recreated empty on next access.
  Future<void> clearCache() async {
    final tempDirectory = await _ref.read(
      accountScopedTempDirectoryProvider.future,
    );
    if (await tempDirectory.exists()) {
      await tempDirectory.delete(recursive: true);
    }
  }
}

final dataCleanupControllerProvider = Provider<DataCleanupController>(
  (ref) => DataCleanupController(ref),
);
