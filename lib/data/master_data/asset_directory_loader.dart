import 'dart:convert';

import 'package:flutter/services.dart' show AssetBundle, AssetManifest;

/// Loads one entity per `.json` file found under [directoryPath] in the
/// asset manifest, instead of a single combined list file.
Future<List<T>> loadJsonEntitiesFromDirectory<T>({
  required AssetBundle bundle,
  required String directoryPath,
  required T Function(Map<String, dynamic> json) fromJson,
}) async {
  final manifest = await AssetManifest.loadFromAssetBundle(bundle);
  final assetPaths =
      manifest
          .listAssets()
          .where(
            (path) => path.startsWith(directoryPath) && path.endsWith('.json'),
          )
          .toList()
        ..sort();

  final entities = <T>[];
  for (final path in assetPaths) {
    final raw = await bundle.loadString(path);
    entities.add(fromJson(jsonDecode(raw) as Map<String, dynamic>));
  }
  return entities;
}
