import 'package:data_pack/data_pack.dart';

import 'qr_code_entity.dart';

/// Converts a domain [QrCode] to its persisted [QrCodeEntity] form.
extension QrCodeEntityMapper on QrCode {
  QrCodeEntity toEntity({int id = 0}) {
    return QrCodeEntity(
      id: id,
      cuid: this.id,
      rawValue: rawValue,
      hash: hash,
      createdAt: createdAt,
      name: name,
    );
  }
}

/// Rebuilds the domain [QrCode] from a persisted [QrCodeEntity].
extension QrCodeEntityToDomain on QrCodeEntity {
  QrCode toDomain() {
    return QrCode(
      id: cuid,
      rawValue: rawValue,
      hash: hash,
      createdAt: createdAt,
      name: name,
    );
  }
}
