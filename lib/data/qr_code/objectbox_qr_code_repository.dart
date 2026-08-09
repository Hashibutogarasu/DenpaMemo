import '../../domain/denpa_men/denpa_men.dart';
import '../../domain/master_data/master_data.dart';
import '../../domain/qr_code/qr_code.dart';
import '../../domain/qr_code/qr_code_repository.dart';
import '../../objectbox.g.dart';
import '../denpa_men/denpa_men_mapper.dart';
import '../objectbox/objectbox.dart';
import 'qr_code_mapper.dart';

/// [QrCodeRepository] backed by ObjectBox, saving the [QrCode] and its
/// linked [DenpaMen] individuals in one write transaction.
class ObjectBoxQrCodeRepository implements QrCodeRepository {
  ObjectBoxQrCodeRepository(this._objectBox);

  final ObjectBox _objectBox;

  @override
  void saveWithDenpaMens(
    QrCode qrCode,
    List<DenpaMen> denpaMens,
    MasterData masterData,
  ) {
    _objectBox.store.runInTransaction(TxMode.write, () {
      final qrCodeId = _objectBox.qrCodeBox.put(qrCode.toEntity());
      final now = DateTime.now();
      final entities = [
        for (final denpaMen in denpaMens)
          denpaMen.toEntity(createdAt: now)..qrCode.targetId = qrCodeId,
      ];
      _objectBox.denpaMenBox.putMany(entities);
    });
  }
}
