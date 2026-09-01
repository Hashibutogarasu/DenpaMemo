import 'package:data_pack/data_pack.dart';

import '../../objectbox.g.dart';
import '../objectbox/objectbox.dart';
import 'cloud_file_entity.dart';
import 'cloud_file_mapper.dart';

/// [CloudFileRepository] backed by the [CloudFileEntity] ObjectBox box.
class ObjectBoxCloudFileRepository implements CloudFileRepository {
  ObjectBoxCloudFileRepository(this._objectBox);

  final ObjectBox _objectBox;

  Box<CloudFileEntity> get _box => _objectBox.cloudFileBox;

  @override
  List<CloudFile> getAll() {
    final query = (_box.query()..order(CloudFileEntity_.uploadedAt)).build();
    try {
      return [for (final entity in query.find()) entity.toDomain()];
    } finally {
      query.close();
    }
  }

  @override
  void save(CloudFile cloudFile) {
    final query = _box
        .query(CloudFileEntity_.fileId.equals(cloudFile.fileId))
        .build();
    final existingId = () {
      try {
        return query.findFirst()?.id ?? 0;
      } finally {
        query.close();
      }
    }();
    _box.put(cloudFile.toEntity(id: existingId));
  }

  @override
  void delete(String fileId) {
    final query = _box.query(CloudFileEntity_.fileId.equals(fileId)).build();
    try {
      final entity = query.findFirst();
      if (entity != null) {
        _box.remove(entity.id);
      }
    } finally {
      query.close();
    }
  }
}
