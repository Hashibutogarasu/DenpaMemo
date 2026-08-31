import 'qr_code.dart';

/// A saved [QrCode] paired with its storage id, as returned by
/// [QrCodeRepository]. The domain [QrCode] itself carries its own [QrCode.id]
/// (a cuid), which is distinct from this storage id.
class QrCodeRecord {
  const QrCodeRecord({required this.id, required this.qrCode});

  final int id;
  final QrCode qrCode;
}
