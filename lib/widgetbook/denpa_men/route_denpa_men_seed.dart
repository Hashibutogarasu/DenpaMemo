import '../../data/denpa_men/objectbox_denpa_men_repository.dart';
import '../../data/qr_code/objectbox_qr_code_repository.dart';
import '../core/widgetbook_scope.dart';
import 'route_denpa_men_data.dart';
import 'package:data_pack/data_pack.dart';

/// Seeds [widgetbookObjectBox] with [RouteDenpaMenData.all]. Idempotent:
/// already-seeded QR codes/individuals (by hash/cuid) are skipped, so a
/// re-run (e.g. a hot restart that doesn't actually clear the in-memory
/// store) doesn't hit ObjectBox's unique-constraint errors.
void seedRouteDenpaMenIntoObjectBox() {
  final qrCodeRepository = ObjectBoxQrCodeRepository(widgetbookObjectBox);
  final denpaMenRepository = ObjectBoxDenpaMenRepository(widgetbookObjectBox);

  final qrCodeIds = {
    for (final denpaMen in RouteDenpaMenData.all)
      if (denpaMen.qrCodeId != null) denpaMen.qrCodeId!,
  };
  for (final qrCodeId in qrCodeIds) {
    final qrCode = createQrCode(qrCodeId, id: qrCodeId);
    if (qrCodeRepository.findByHash(qrCode.hash) != null) {
      continue;
    }
    qrCodeRepository.saveWithDenpaMens(
      qrCode,
      const [],
      RouteDenpaMenData.masterData,
    );
  }

  for (final denpaMen in RouteDenpaMenData.all) {
    if (denpaMenRepository.findByCuid(denpaMen.id, RouteDenpaMenData.masterData) !=
        null) {
      continue;
    }
    denpaMenRepository.save(denpaMen);
  }
}
