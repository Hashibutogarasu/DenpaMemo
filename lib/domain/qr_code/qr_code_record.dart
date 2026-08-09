import 'qr_code.dart';

/// A saved [QrCode] paired with its storage id, as returned by
/// [QrCodeRepository]. The domain [QrCode] itself carries no id since it is
/// only meaningful once persisted.
class QrCodeRecord {
  const QrCodeRecord({required this.id, required this.qrCode});

  final int id;
  final QrCode qrCode;
}
