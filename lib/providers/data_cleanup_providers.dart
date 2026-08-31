import 'dart:io';

import 'package:flutter/services.dart' show AssetManifest, rootBundle;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:path/path.dart' as path;

import 'account_scoped_paths_providers.dart';
import 'objectbox_providers.dart';

/// Drives the "data management" page's housekeeping actions: removing
/// orphaned icon folders from the account's persistent data directory, and
/// wiping its temporary/cache directory outright.
class DataCleanupController {
  const DataCleanupController(this._ref);

  final Ref _ref;

  /// Deletes icon folders under the account's app directory that no longer
  /// correspond to an existing `DenpaMen` or a bundled monster asset.
  /// Returns how many folders were removed.
  Future<int> cleanupApplicationFolder() async {
    final appDirectory = await _ref.read(
      accountScopedAppDirectoryProvider.future,
    );
    final objectBox = _ref.read(objectBoxProvider);
    final validDenpaMenIds = objectBox.denpaMenBox
        .getAll()
        .map((entity) => entity.cuid)
        .toSet();

    final manifest = await AssetManifest.loadFromAssetBundle(rootBundle);
    final assets = manifest.listAssets();
    bool isValidMonsterId(String id) =>
        assets.contains('assets/data/icons/monster/$id.png');

    var removedCount = 0;
    removedCount += await _removeOrphanedIconFolders(
      Directory(path.join(appDirectory.path, 'icons', 'denpamens')),
      isValidId: validDenpaMenIds.contains,
    );
    removedCount += await _removeOrphanedIconFolders(
      Directory(path.join(appDirectory.path, 'icons', 'monsters')),
      isValidId: isValidMonsterId,
    );
    return removedCount;
  }

  Future<int> _removeOrphanedIconFolders(
    Directory categoryDirectory, {
    required bool Function(String id) isValidId,
  }) async {
    if (!await categoryDirectory.exists()) {
      return 0;
    }
    var removedCount = 0;
    await for (final entry in categoryDirectory.list()) {
      if (entry is! Directory) {
        continue;
      }
      if (!isValidId(path.basename(entry.path))) {
        await entry.delete(recursive: true);
        removedCount++;
      }
    }
    return removedCount;
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
