import 'package:objectbox/objectbox.dart';

/// Persisted representation of a
/// [CloudFile](../../../modules/DataPack/lib/src/cloud_file/cloud_file.dart).
@Entity()
class CloudFileEntity {
  @Id()
  int id;

  @Unique()
  String fileId;

  String filename;

  @Property(type: PropertyType.date)
  DateTime uploadedAt;

  CloudFileEntity({
    this.id = 0,
    required this.fileId,
    required this.filename,
    required this.uploadedAt,
  });
}
