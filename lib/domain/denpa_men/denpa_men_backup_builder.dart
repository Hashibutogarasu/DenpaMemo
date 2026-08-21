import '../qr_code/qr_code.dart';
import 'denpa_men.dart';
import 'denpa_men_backup_entry.dart';

/// Pairs each of [denpaMenList] with the [QrCode] it references (by
/// [DenpaMen.qrCodeId]) out of [availableQrCodes], so an export includes
/// the QR code substance (rawValue/hash/name) alongside the individual
/// rather than only its id. Individuals with no [DenpaMen.qrCodeId], or
/// whose referenced QR code is not in [availableQrCodes], get a null
/// [DenpaMenBackupEntry.qrCode].
List<DenpaMenBackupEntry> buildDenpaMenBackupEntries(
  List<DenpaMen> denpaMenList,
  List<QrCode> availableQrCodes,
) {
  final qrCodesById = {for (final qrCode in availableQrCodes) qrCode.id: qrCode};
  return [
    for (final denpaMen in denpaMenList)
      DenpaMenBackupEntry(denpaMen: denpaMen, qrCode: qrCodesById[denpaMen.qrCodeId]),
  ];
}
