import 'dart:convert';
import 'dart:io';

import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';

/// Reads and writes each `DenpaMen`'s icon image file, stored alongside
/// the ObjectBox database directory (`getApplicationDocumentsDirectory()`)
/// under `icons/denpamens/<denpaMenId>/`. That directory holds the image
/// file itself plus a `metadata.json` recording its file name, so loading
/// an icon means: resolve the directory, read `metadata.json`, read the
/// file name it records, then load that file.
class DenpaMenIconStorage {
  const DenpaMenIconStorage({
    this.metadataFileName = 'metadata.json',
    this.fileNameKey = 'fileName',
  });

  final String metadataFileName;
  final String fileNameKey;

  Future<Directory> _iconDirectory(String denpaMenId) async {
    final documentsDirectory = await getApplicationDocumentsDirectory();
    return Directory(
      path.join(documentsDirectory.path, 'icons', 'denpamens', denpaMenId),
    );
  }

  Future<File?> loadIcon(String denpaMenId) async {
    final directory = await _iconDirectory(denpaMenId);
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

  Future<File> saveIcon(String denpaMenId, File croppedImage) async {
    final directory = await _iconDirectory(denpaMenId);
    await directory.create(recursive: true);

    final fileName = 'icon${path.extension(croppedImage.path)}';
    final destination = File(path.join(directory.path, fileName));
    await croppedImage.copy(destination.path);

    final metadataFile = File(path.join(directory.path, metadataFileName));
    await metadataFile.writeAsString(
      jsonEncode({fileNameKey: fileName}),
    );

    return destination;
  }
}
