// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'additional_correction.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_AdditionalCorrection _$AdditionalCorrectionFromJson(
  Map<String, dynamic> json,
) => _AdditionalCorrection(
  hpBonus: (json['hpBonus'] as num?)?.toInt() ?? 0,
  apBonus: (json['apBonus'] as num?)?.toInt() ?? 0,
  attackBonus: (json['attackBonus'] as num?)?.toInt() ?? 0,
  defenseBonus: (json['defenseBonus'] as num?)?.toInt() ?? 0,
  speedBonus: (json['speedBonus'] as num?)?.toInt() ?? 0,
  evasionRateBonus: (json['evasionRateBonus'] as num?)?.toInt() ?? 0,
  statBonusName: json['statBonusName'] as String? ?? '',
  attributeResistances:
      (json['attributeResistances'] as List<dynamic>?)
          ?.map((e) => AttributeResistance.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const <AttributeResistance>[],
  attributeResistanceName: json['attributeResistanceName'] as String? ?? '',
  abnormalityResistances:
      (json['abnormalityResistances'] as List<dynamic>?)
          ?.map(
            (e) => AbnormalityResistance.fromJson(e as Map<String, dynamic>),
          )
          .toList() ??
      const <AbnormalityResistance>[],
  abnormalityResistanceName: json['abnormalityResistanceName'] as String? ?? '',
);

Map<String, dynamic> _$AdditionalCorrectionToJson(
  _AdditionalCorrection instance,
) => <String, dynamic>{
  'hpBonus': instance.hpBonus,
  'apBonus': instance.apBonus,
  'attackBonus': instance.attackBonus,
  'defenseBonus': instance.defenseBonus,
  'speedBonus': instance.speedBonus,
  'evasionRateBonus': instance.evasionRateBonus,
  'statBonusName': instance.statBonusName,
  'attributeResistances': instance.attributeResistances,
  'attributeResistanceName': instance.attributeResistanceName,
  'abnormalityResistances': instance.abnormalityResistances,
  'abnormalityResistanceName': instance.abnormalityResistanceName,
};
