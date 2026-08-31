import 'package:freezed_annotation/freezed_annotation.dart';

import '../qr_code/qr_code.dart';
import 'denpa_men.dart';

part 'denpa_men_backup_entry.freezed.dart';
part 'denpa_men_backup_entry.g.dart';

/// One exported/imported [DenpaMen] paired with the [QrCode] it
/// references, so an import can restore the QR code substance
/// (rawValue/hash/name) instead of only [DenpaMen.qrCodeId].
@freezed
abstract class DenpaMenBackupEntry with _$DenpaMenBackupEntry {
  const factory DenpaMenBackupEntry({
    required DenpaMen denpaMen,
    QrCode? qrCode,
  }) = _DenpaMenBackupEntry;

  factory DenpaMenBackupEntry.fromJson(Map<String, dynamic> json) =>
      _$DenpaMenBackupEntryFromJson(json);
}
