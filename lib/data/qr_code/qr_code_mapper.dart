import '../../domain/qr_code/qr_code.dart';
import 'qr_code_entity.dart';

/// Converts a domain [QrCode] to its persisted [QrCodeEntity] form.
extension QrCodeEntityMapper on QrCode {
  QrCodeEntity toEntity({int id = 0}) {
    return QrCodeEntity(
      id: id,
      rawValue: rawValue,
      hash: hash,
      createdAt: createdAt,
    );
  }
}

/// Rebuilds the domain [QrCode] from a persisted [QrCodeEntity].
extension QrCodeEntityToDomain on QrCodeEntity {
  QrCode toDomain() {
    return QrCode(rawValue: rawValue, hash: hash, createdAt: createdAt);
  }
}
