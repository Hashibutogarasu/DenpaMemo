import 'package:data_pack/data_pack.dart';

import 'cloud_file_entity.dart';

/// Converts a domain [CloudFile] to its persisted [CloudFileEntity] form.
extension CloudFileEntityMapper on CloudFile {
  CloudFileEntity toEntity({int id = 0}) {
    return CloudFileEntity(
      id: id,
      fileId: fileId,
      filename: filename,
      uploadedAt: uploadedAt,
    );
  }
}

/// Rebuilds the domain [CloudFile] from a persisted [CloudFileEntity].
extension CloudFileEntityToDomain on CloudFileEntity {
  CloudFile toDomain() {
    return CloudFile(
      fileId: fileId,
      filename: filename,
      uploadedAt: uploadedAt,
    );
  }
}
