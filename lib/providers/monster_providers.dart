import 'dart:io';

import 'package:app_datas/app_datas.dart';
import 'package:flutter/services.dart' show AssetManifest, rootBundle;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:path/path.dart' as path;

import '../data/icon/entity_icon_storage.dart';

final monsterIconStorageProvider = Provider<EntityIconStorage>((ref) {
  return const EntityIconStorage('monsters');
});

/// Loads the icon file for the [Monster] with the given id. Monsters are
/// not user-editable like `DenpaMen`, so instead of a picker/cropper flow,
/// their icon is auto-registered on first load from a bundled asset named
/// `assets/data/icons/monster/<monsterId>.png`, if one exists.
final monsterIconProvider = FutureProvider.family<File?, String>((
  ref,
  monsterId,
) async {
  final storage = ref.watch(monsterIconStorageProvider);
  final existing = await storage.loadIcon(monsterId);
  if (existing != null) {
    return existing;
  }

  final assetPath = 'assets/data/icons/monster/$monsterId.png';
  final manifest = await AssetManifest.loadFromAssetBundle(rootBundle);
  if (!manifest.listAssets().contains(assetPath)) {
    return null;
  }

  final bytes = await rootBundle.load(assetPath);
  final packageInfo = await PackageInfo.fromPlatform();
  final tempDirectory = await AppPaths.tempAppDirectory(
    packageInfo.packageName,
  );
  final tempFile = await File(
    path.join(tempDirectory.path, '$monsterId.png'),
  ).writeAsBytes(bytes.buffer.asUint8List(bytes.offsetInBytes, bytes.lengthInBytes));
  try {
    return await storage.saveIcon(monsterId, tempFile);
  } finally {
    if (await tempFile.exists()) {
      await tempFile.delete();
    }
  }
});
