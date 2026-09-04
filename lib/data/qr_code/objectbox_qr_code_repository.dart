import '../../objectbox.g.dart';
import '../denpa_men/denpa_men_mapper.dart';
import '../objectbox/objectbox.dart';
import 'qr_code_entity.dart';
import 'qr_code_mapper.dart';
import 'package:data_pack/data_pack.dart';

/// [QrCodeRepository] backed by ObjectBox, saving the [QrCode] and its
/// linked [DenpaMen] individuals in one write transaction.
class ObjectBoxQrCodeRepository implements QrCodeRepository {
  ObjectBoxQrCodeRepository(this._objectBox);

  final ObjectBox _objectBox;

  QueryBuilder<QrCodeEntity> _orderedQuery() =>
      _objectBox.qrCodeBox.query()..order(QrCodeEntity_.createdAt);

  @override
  List<QrCodeRecord> getAll() {
    final query = _orderedQuery().build();
    try {
      return [
        for (final entity in query.find())
          QrCodeRecord(id: entity.id, qrCode: entity.toDomain()),
      ];
    } finally {
      query.close();
    }
  }

  @override
  Stream<List<QrCodeRecord>> watchAll() {
    return _orderedQuery()
        .watch(triggerImmediately: true)
        .map(
          (query) => [
            for (final entity in query.find())
              QrCodeRecord(id: entity.id, qrCode: entity.toDomain()),
          ],
        );
  }

  @override
  QrCodeRecord? findByHash(String hash) {
    final query = _objectBox.qrCodeBox
        .query(QrCodeEntity_.hash.equals(hash))
        .build();
    try {
      final entity = query.findFirst();
      return entity == null
          ? null
          : QrCodeRecord(id: entity.id, qrCode: entity.toDomain());
    } finally {
      query.close();
    }
  }

  @override
  void saveWithDenpaMens(
    QrCode qrCode,
    List<DenpaMen> denpaMens,
    MasterData masterData, {
    int id = 0,
  }) {
    _objectBox.store.runInTransaction(TxMode.write, () {
      final qrCodeId = _objectBox.qrCodeBox.put(qrCode.toEntity(id: id));
      final now = DateTime.now();
      final entities = [
        for (final denpaMen in denpaMens)
          denpaMen.toEntity(createdAt: now)..qrCode.targetId = qrCodeId,
      ];
      _objectBox.denpaMenBox.putMany(entities);
    });
  }
}
