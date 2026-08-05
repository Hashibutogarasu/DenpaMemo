import 'package:freezed_annotation/freezed_annotation.dart';

part 'abnormality_resistance.freezed.dart';
part 'abnormality_resistance.g.dart';

@freezed
abstract class AbnormalityResistance with _$AbnormalityResistance {
  const factory AbnormalityResistance({
    required String abnormalityId,
    required int value,
  }) = _AbnormalityResistance;

  factory AbnormalityResistance.fromJson(Map<String, dynamic> json) =>
      _$AbnormalityResistanceFromJson(json);
}
