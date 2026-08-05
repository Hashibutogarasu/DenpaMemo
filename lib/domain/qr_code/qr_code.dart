import 'package:freezed_annotation/freezed_annotation.dart';

import '../denpa_men/denpa_men.dart';

part 'qr_code.freezed.dart';
part 'qr_code.g.dart';

@freezed
abstract class QRCode with _$QRCode {
  const factory QRCode({
    required String rawString,
    @Default([]) List<DenpaMen> denpaMens,
    String? memo,
    required DateTime createdAt,
    DateTime? updatedAt,
    DateTime? deletedAt,
  }) = _QRCode;

  factory QRCode.fromJson(Map<String, dynamic> json) =>
      _$QRCodeFromJson(json);
}
