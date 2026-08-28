import 'package:data_pack/data_pack.dart';

/// Sample [QrCode] data for Widgetbook use cases.
abstract final class QrCodeData {
  static final QrCode qrCode = createQrCode(
    'widgetbook-qr',
    id: 'qr-1',
    createdAt: DateTime(2026, 1, 1),
  );

  static final qrCodeRecord = QrCodeRecord(id: 1, qrCode: qrCode);
}
