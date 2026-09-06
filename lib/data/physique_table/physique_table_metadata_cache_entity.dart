import 'package:objectbox/objectbox.dart';

/// Singleton cache of the two small, rarely-changing payloads the
/// physique table editor needs before it can render anything:
/// `GET /tables/types` (JSON-encoded `List<TableDefinition>`) and the
/// antenna/status category metadata (JSON-encoded `PhysiqueTableMetadata`).
/// Populated whenever a live fetch succeeds, so a later offline launch
/// can fall back to whatever was last seen instead of hanging forever.
@Entity()
class PhysiqueTableMetadataCacheEntity {
  @Id()
  int id;

  String? tableTypesJson;

  String? metadataJson;

  PhysiqueTableMetadataCacheEntity({
    this.id = 0,
    this.tableTypesJson,
    this.metadataJson,
  });
}
