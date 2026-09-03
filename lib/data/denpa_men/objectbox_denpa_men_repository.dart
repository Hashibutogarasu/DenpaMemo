import 'package:data_cache/data_cache.dart';
import 'package:data_pack/data_pack.dart';

import '../../objectbox.g.dart';
import '../objectbox/objectbox.dart';
import 'denpa_men_entity.dart';
import 'denpa_men_mapper.dart';

/// [DenpaMenRepository] backed by the [DenpaMenEntity] ObjectBox box, newest
/// entries last. [cacheIndexRepository], when provided, is used to persist
/// and replay each record's resistance snapshot; omitting it preserves the
/// original recompute-on-load behavior.
class ObjectBoxDenpaMenRepository implements DenpaMenRepository {
  ObjectBoxDenpaMenRepository(this._objectBox, {CacheIndexRepository? cacheIndexRepository})
    : _cacheIndexRepository = cacheIndexRepository;

  final ObjectBox _objectBox;
  final CacheIndexRepository? _cacheIndexRepository;

  Box<DenpaMenEntity> get _box => _objectBox.denpaMenBox;

  QueryBuilder<DenpaMenEntity> _orderedQuery() =>
      _box.query()..order(DenpaMenEntity_.createdAt);

  @override
  List<DenpaMenRecord> getAll(MasterData masterData) {
    final query = _orderedQuery().build();
    try {
      return [
        for (final entity in query.find())
          DenpaMenRecord(id: entity.id, denpaMen: _toDomain(entity, masterData)),
      ];
    } finally {
      query.close();
    }
  }

  @override
  List<DenpaMenRecord> getRange(
    MasterData masterData, {
    required int offset,
    required int limit,
  }) {
    final query = _orderedQuery().build()
      ..offset = offset
      ..limit = limit;
    try {
      return [
        for (final entity in query.find())
          DenpaMenRecord(id: entity.id, denpaMen: _toDomain(entity, masterData)),
      ];
    } finally {
      query.close();
    }
  }

  @override
  Stream<List<DenpaMenRecord>> watchAll(MasterData masterData) {
    return _orderedQuery()
        .watch(triggerImmediately: true)
        .map(
          (query) => [
            for (final entity in query.find())
              DenpaMenRecord(
                id: entity.id,
                denpaMen: _toDomain(entity, masterData),
              ),
          ],
        );
  }

  @override
  int save(DenpaMen denpaMen, {int id = 0}) {
    final createdAt = id == 0 ? DateTime.now() : _box.get(id)!.createdAt;
    final entity = denpaMen.toEntity(id: id, createdAt: createdAt);
    final qrCodeId = denpaMen.qrCodeId;
    if (qrCodeId != null) {
      final query = _objectBox.qrCodeBox
          .query(QrCodeEntity_.cuid.equals(qrCodeId))
          .build();
      try {
        final qrCodeEntity = query.findFirst();
        if (qrCodeEntity != null) {
          entity.qrCode.target = qrCodeEntity;
        }
      } finally {
        query.close();
      }
    }
    final savedId = _box.put(entity);
    _cacheIndexRepository?.saveSync(
      denpaMen.id,
      DenpaMenResistanceCacheInput.fromDenpaMen(denpaMen),
      DenpaMenResistanceCacheOutput((
        abnormalityResistances: denpaMen.abnormalityResistances,
        attributeResistance: denpaMen.attributeResistance,
      )),
    );
    return savedId;
  }

  @override
  DenpaMenRecord? findByCuid(String cuid, MasterData masterData) {
    final query = _box.query(DenpaMenEntity_.cuid.equals(cuid)).build();
    try {
      final entity = query.findFirst();
      return entity == null
          ? null
          : DenpaMenRecord(id: entity.id, denpaMen: _toDomain(entity, masterData));
    } finally {
      query.close();
    }
  }

  @override
  void delete(int id) {
    _box.remove(id);
  }

  @override
  List<DenpaMenRecord> getChildrens(DenpaMen denpaMen, MasterData masterData) {
    if (denpaMen.parentIds.isEmpty) {
      return const [];
    }
    final query = (_box.query(
      DenpaMenEntity_.cuid.oneOf(denpaMen.parentIds),
    )..order(DenpaMenEntity_.createdAt)).build();
    try {
      return [
        for (final entity in query.find())
          DenpaMenRecord(id: entity.id, denpaMen: _toDomain(entity, masterData)),
      ];
    } finally {
      query.close();
    }
  }

  DenpaMen _toDomain(DenpaMenEntity entity, MasterData masterData) =>
      entity.toDomain(masterData, cacheIndexRepository: _cacheIndexRepository);
}
