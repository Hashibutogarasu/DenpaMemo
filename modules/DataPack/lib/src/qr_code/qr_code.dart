import 'package:freezed_annotation/freezed_annotation.dart';

part 'qr_code.freezed.dart';
part 'qr_code.g.dart';

/// Instances must be created through `createQrCode` in
/// `qr_code_factory.dart`, which derives [hash] from [rawValue].
@freezed
abstract class QrCode with _$QrCode {
  const factory QrCode({
    required String id,
    required String rawValue,
    required String hash,
    required DateTime createdAt,
    String? name,
  }) = _QrCode;

  factory QrCode.fromJson(Map<String, dynamic> json) =>
      _$QrCodeFromJson(json);
}
