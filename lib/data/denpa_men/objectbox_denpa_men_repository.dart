import '../../domain/denpa_men/denpa_men.dart';
import '../../domain/denpa_men/denpa_men_record.dart';
import '../../domain/denpa_men/denpa_men_repository.dart';
import '../../domain/master_data/master_data.dart';
import '../../objectbox.g.dart';
import '../objectbox/objectbox.dart';
import 'denpa_men_entity.dart';
import 'denpa_men_mapper.dart';

/// [DenpaMenRepository] backed by the [DenpaMenEntity] ObjectBox box, newest
/// entries last.
class ObjectBoxDenpaMenRepository implements DenpaMenRepository {
  ObjectBoxDenpaMenRepository(this._objectBox);

  final ObjectBox _objectBox;

  Box<DenpaMenEntity> get _box => _objectBox.denpaMenBox;

  QueryBuilder<DenpaMenEntity> _orderedQuery() =>
      _box.query()..order(DenpaMenEntity_.createdAt);

  @override
  List<DenpaMenRecord> getAll(MasterData masterData) {
    final query = _orderedQuery().build();
    try {
      return [
        for (final entity in query.find())
          DenpaMenRecord(id: entity.id, denpaMen: entity.toDomain(masterData)),
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
                denpaMen: entity.toDomain(masterData),
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
    return _box.put(entity);
  }

  @override
  DenpaMenRecord? findByCuid(String cuid, MasterData masterData) {
    final query = _box.query(DenpaMenEntity_.cuid.equals(cuid)).build();
    try {
      final entity = query.findFirst();
      return entity == null
          ? null
          : DenpaMenRecord(id: entity.id, denpaMen: entity.toDomain(masterData));
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
          DenpaMenRecord(id: entity.id, denpaMen: entity.toDomain(masterData)),
      ];
    } finally {
      query.close();
    }
  }
}
