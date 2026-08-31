import 'dart:convert';
import 'dart:io';

import 'package:app_datas/app_datas.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:path/path.dart' as path;

/// Reads and writes an entity's icon image file, stored alongside the
/// ObjectBox database directory (under the app's [AppPaths.appDirectory])
/// under `icons/<category>/<id>/`. That directory holds the image file
/// itself plus a `metadata.json` recording its file name, so loading an
/// icon means: resolve the directory, read `metadata.json`, read the file
/// name it records, then load that file. Shared by every entity that
/// needs id-keyed icons (`DenpaMen`, `Monster`), each using its own
/// [category] subdirectory.
class EntityIconStorage {
  const EntityIconStorage(
    this.category, {
    this.metadataFileName = 'metadata.json',
    this.fileNameKey = 'fileName',
  });

  final String category;
  final String metadataFileName;
  final String fileNameKey;

  Future<Directory> _iconDirectory(String id) async {
    final packageInfo = await PackageInfo.fromPlatform();
    final appDirectory = await AppPaths.appDirectory(packageInfo.packageName);
    return Directory(path.join(appDirectory.path, 'icons', category, id));
  }

  Future<File?> loadIcon(String id) async {
    final directory = await _iconDirectory(id);
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

  Future<File> saveIcon(String id, File croppedImage) async {
    final directory = await _iconDirectory(id);
    await directory.create(recursive: true);

    final fileName = 'icon${path.extension(croppedImage.path)}';
    final destination = File(path.join(directory.path, fileName));
    await croppedImage.copy(destination.path);

    final metadataFile = File(path.join(directory.path, metadataFileName));
    await metadataFile.writeAsString(jsonEncode({fileNameKey: fileName}));

    return destination;
  }
}
