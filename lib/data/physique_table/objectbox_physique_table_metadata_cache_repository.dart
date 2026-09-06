import 'dart:convert';

import 'package:api_client/api_client.dart';
import 'package:collection/collection.dart';
import 'package:data_pack/data_pack.dart';

import '../../objectbox.g.dart';
import '../objectbox/objectbox.dart';
import 'physique_table_metadata_cache_entity.dart';

/// Local cache of the two small payloads that gate the physique table
/// editor's entry screen: registered table types and antenna/status
/// category metadata. Lets `tableTypesProvider` and its metadata
/// counterpart fall back to the last known value instead of hanging
/// forever when the server is unreachable.
class PhysiqueTableMetadataCacheRepository {
  PhysiqueTableMetadataCacheRepository(this._objectBox);

  final ObjectBox _objectBox;

  Box<PhysiqueTableMetadataCacheEntity> get _box =>
      _objectBox.physiqueTableMetadataCacheBox;

  /// The single cache row, created on first write.
  PhysiqueTableMetadataCacheEntity _singleton() {
    final existing = _box.getAll();
    return existing.isEmpty
        ? PhysiqueTableMetadataCacheEntity()
        : existing.first;
  }

  void saveTableTypes(List<TableDefinition> types) {
    final entity = _singleton();
    entity.tableTypesJson = jsonEncode([
      for (final type in types) type.toJson(),
    ]);
    _box.put(entity);
  }

  List<TableDefinition>? cachedTableTypes() {
    final json = _box.getAll().firstOrNull?.tableTypesJson;
    if (json == null) return null;
    return [
      for (final row in jsonDecode(json) as List<dynamic>)
        TableDefinition.fromJson(row as Map<String, dynamic>),
    ];
  }

  void saveMetadata(PhysiqueTableMetadata metadata) {
    final entity = _singleton();
    entity.metadataJson = jsonEncode(metadata.toJson());
    _box.put(entity);
  }

  PhysiqueTableMetadata? cachedMetadata() {
    final json = _box.getAll().firstOrNull?.metadataJson;
    if (json == null) return null;
    return PhysiqueTableMetadata.fromJson(
      jsonDecode(json) as Map<String, dynamic>,
    );
  }
}
