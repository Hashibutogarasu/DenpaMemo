import 'dart:convert';
import 'dart:io';

import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';

/// Reads and writes an entity's icon image file, stored alongside the
/// ObjectBox database directory (`getApplicationDocumentsDirectory()`)
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
    final documentsDirectory = await getApplicationDocumentsDirectory();
    return Directory(
      path.join(documentsDirectory.path, 'icons', category, id),
    );
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
