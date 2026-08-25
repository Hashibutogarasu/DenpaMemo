import '../../domain/qr_code/qr_code.dart';
import '../../domain/qr_code/qr_code_factory.dart';
import '../../domain/qr_code/qr_code_record.dart';

/// Sample [QrCode] data for Widgetbook use cases.
abstract final class QrCodeData {
  static final QrCode qrCode = createQrCode(
    'widgetbook-qr',
    id: 'qr-1',
    createdAt: DateTime(2026, 1, 1),
  );

  static final qrCodeRecord = QrCodeRecord(id: 1, qrCode: qrCode);
}
