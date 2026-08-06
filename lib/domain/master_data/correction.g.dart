// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'correction.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Correction _$CorrectionFromJson(Map<String, dynamic> json) => _Correction(
  id: json['id'] as String,
  displayName: json['displayName'] as String,
  hpBonus: (json['hpBonus'] as num?)?.toInt() ?? 0,
  apBonus: (json['apBonus'] as num?)?.toInt() ?? 0,
  attackBonus: (json['attackBonus'] as num?)?.toInt() ?? 0,
  defenseBonus: (json['defenseBonus'] as num?)?.toInt() ?? 0,
  speedBonus: (json['speedBonus'] as num?)?.toInt() ?? 0,
  evasionRateBonus: (json['evasionRateBonus'] as num?)?.toInt() ?? 0,
  abnormalityResistanceBonuses:
      (json['abnormalityResistanceBonuses'] as Map<String, dynamic>?)?.map(
        (k, e) => MapEntry(k, (e as num).toInt()),
      ) ??
      const {},
);

Map<String, dynamic> _$CorrectionToJson(_Correction instance) =>
    <String, dynamic>{
      'id': instance.id,
      'displayName': instance.displayName,
      'hpBonus': instance.hpBonus,
      'apBonus': instance.apBonus,
      'attackBonus': instance.attackBonus,
      'defenseBonus': instance.defenseBonus,
      'speedBonus': instance.speedBonus,
      'evasionRateBonus': instance.evasionRateBonus,
      'abnormalityResistanceBonuses': instance.abnormalityResistanceBonuses,
    };
