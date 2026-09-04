import 'dart:convert';
import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:path/path.dart' as path;

import '../../providers/account_scoped_paths_providers.dart';

/// Reads and writes an entity's per-slot icon image files, stored
/// alongside the ObjectBox database directory (under the current
/// account's [accountScopedAppDirectoryProvider]) under
/// `icons/<category>/<id>/<slot>/`. Each slot directory holds the image
/// file itself plus a `metadata.json` recording its file name, so loading
/// an icon means: resolve the slot directory, read `metadata.json`, read
/// the file name it records, then load that file. Shared by every entity
/// that needs id-keyed icons (`DenpaMen`, `Monster`), each using its own
/// [category] subdirectory. [slot] is an opaque string (for `DenpaMen`,
/// callers pass `DenpaMenImageSlotType.name`); entities with only one
/// kind of icon (e.g. `Monster`) can omit it and rely on [defaultSlot].
class EntityIconStorage {
  const EntityIconStorage(
    this.category,
    this._ref, {
    this.metadataFileName = 'metadata.json',
    this.fileNameKey = 'fileName',
  });

  static const String defaultSlot = 'icon';

  final String category;
  final Ref _ref;
  final String metadataFileName;
  final String fileNameKey;

  Future<Directory> _categoryDirectory() async {
    final appDirectory = await _ref.read(
      accountScopedAppDirectoryProvider.future,
    );
    return Directory(path.join(appDirectory.path, 'icons', category));
  }

  Future<Directory> _slotDirectory(String id, String slot) async {
    final categoryDirectory = await _categoryDirectory();
    return Directory(path.join(categoryDirectory.path, id, slot));
  }

  /// Moves an entity's pre-multi-slot layout (`icons/<category>/<id>/`,
  /// holding the image and `metadata.json` directly) into the new
  /// `icons/<category>/<id>/icon/` layout, if it hasn't been moved
  /// already. Only [EntityIconStorage.defaultSlot] can have legacy data, since
  /// multi-slot support didn't exist before this migration was written.
  Future<void> _migrateLegacyFlatLayoutIfNeeded(String id) async {
    final newSlotDirectory = await _slotDirectory(
      id,
      EntityIconStorage.defaultSlot,
    );
    final newMetadataFile = File(
      path.join(newSlotDirectory.path, metadataFileName),
    );
    if (await newMetadataFile.exists()) {
      return;
    }

    final categoryDirectory = await _categoryDirectory();
    final legacyDirectory = Directory(path.join(categoryDirectory.path, id));
    final legacyMetadataFile = File(
      path.join(legacyDirectory.path, metadataFileName),
    );
    if (!await legacyMetadataFile.exists()) {
      return;
    }

    final metadata =
        jsonDecode(await legacyMetadataFile.readAsString())
            as Map<String, dynamic>;
    final fileName = metadata[fileNameKey] as String?;
    await newSlotDirectory.create(recursive: true);
    if (fileName != null) {
      final legacyImageFile = File(path.join(legacyDirectory.path, fileName));
      if (await legacyImageFile.exists()) {
        await legacyImageFile.rename(
          path.join(newSlotDirectory.path, fileName),
        );
      }
    }
    await legacyMetadataFile.rename(newMetadataFile.path);
  }

  Future<File?> loadIcon(
    String id, {
    String slot = EntityIconStorage.defaultSlot,
  }) async {
    if (slot == EntityIconStorage.defaultSlot) {
      await _migrateLegacyFlatLayoutIfNeeded(id);
    }
    final directory = await _slotDirectory(id, slot);
    final metadataFile = File(path.join(directory.path, metadataFileName));
    if (!await metadataFile.exists()) {
      return null;
    }

    final metadata =
        jsonDecode(await metadataFile.readAsString()) as Map<String, dynamic>;
    final fileName = metadata[fileNameKey] as String?;
    if (fileName == null) {
      return null;
    }

    final imageFile = File(path.join(directory.path, fileName));
    if (!await imageFile.exists()) {
      return null;
    }
    return imageFile;
  }

  Future<File> saveIcon(
    String id,
    File croppedImage, {
    String slot = EntityIconStorage.defaultSlot,
  }) async {
    if (slot == EntityIconStorage.defaultSlot) {
      await _migrateLegacyFlatLayoutIfNeeded(id);
    }
    final directory = await _slotDirectory(id, slot);
    await directory.create(recursive: true);

    final fileName = 'icon${path.extension(croppedImage.path)}';
    final destination = File(path.join(directory.path, fileName));
    await croppedImage.copy(destination.path);

    final metadataFile = File(path.join(directory.path, metadataFileName));
    await metadataFile.writeAsString(jsonEncode({fileNameKey: fileName}));

    return destination;
  }
}
