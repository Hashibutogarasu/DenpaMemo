// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'attribute_resistance.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_AttributeResistance _$AttributeResistanceFromJson(Map<String, dynamic> json) =>
    _AttributeResistance(
      attributeId: json['attributeId'] as String,
      value: (json['value'] as num).toInt(),
    );

Map<String, dynamic> _$AttributeResistanceToJson(
  _AttributeResistance instance,
) => <String, dynamic>{
  'attributeId': instance.attributeId,
  'value': instance.value,
};
