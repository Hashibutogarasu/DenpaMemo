// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'head_shape.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_HeadShape _$HeadShapeFromJson(Map<String, dynamic> json) => _HeadShape(
  id: json['id'] as String,
  abnormalityResistanceBonuses:
      (json['abnormalityResistanceBonuses'] as Map<String, dynamic>?)?.map(
        (k, e) => MapEntry(k, (e as num).toInt()),
      ) ??
      const {},
  hpBonus: (json['hpBonus'] as num?)?.toInt() ?? 0,
  apBonus: (json['apBonus'] as num?)?.toInt() ?? 0,
  attackBonus: (json['attackBonus'] as num?)?.toInt() ?? 0,
  defenseBonus: (json['defenseBonus'] as num?)?.toInt() ?? 0,
  speedBonus: (json['speedBonus'] as num?)?.toInt() ?? 0,
  evasionRateBonus: (json['evasionRateBonus'] as num?)?.toInt() ?? 0,
);

Map<String, dynamic> _$HeadShapeToJson(_HeadShape instance) =>
    <String, dynamic>{
      'id': instance.id,
      'abnormalityResistanceBonuses': instance.abnormalityResistanceBonuses,
      'hpBonus': instance.hpBonus,
      'apBonus': instance.apBonus,
      'attackBonus': instance.attackBonus,
      'defenseBonus': instance.defenseBonus,
      'speedBonus': instance.speedBonus,
      'evasionRateBonus': instance.evasionRateBonus,
    };
