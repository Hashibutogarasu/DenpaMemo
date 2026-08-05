// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'body_color_abnormality_resistance_rule.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_BodyColorAbnormalityResistanceRule
_$BodyColorAbnormalityResistanceRuleFromJson(Map<String, dynamic> json) =>
    _BodyColorAbnormalityResistanceRule(
      colorId: json['colorId'] as String,
      abnormalityResistanceBonuses:
          (json['abnormalityResistanceBonuses'] as Map<String, dynamic>?)?.map(
            (k, e) => MapEntry(k, (e as num).toInt()),
          ) ??
          const {},
    );

Map<String, dynamic> _$BodyColorAbnormalityResistanceRuleToJson(
  _BodyColorAbnormalityResistanceRule instance,
) => <String, dynamic>{
  'colorId': instance.colorId,
  'abnormalityResistanceBonuses': instance.abnormalityResistanceBonuses,
};
