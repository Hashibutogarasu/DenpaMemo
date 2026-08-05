// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'body_color_resistance_rule.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_BodyColorResistanceRule _$BodyColorResistanceRuleFromJson(
  Map<String, dynamic> json,
) => _BodyColorResistanceRule(
  colorId: json['colorId'] as String,
  attributeResistanceBonuses:
      (json['attributeResistanceBonuses'] as Map<String, dynamic>?)?.map(
        (k, e) => MapEntry(k, (e as num).toInt()),
      ) ??
      const {},
  weaknessAttributeId: json['weaknessAttributeId'] as String?,
);

Map<String, dynamic> _$BodyColorResistanceRuleToJson(
  _BodyColorResistanceRule instance,
) => <String, dynamic>{
  'colorId': instance.colorId,
  'attributeResistanceBonuses': instance.attributeResistanceBonuses,
  'weaknessAttributeId': instance.weaknessAttributeId,
};
