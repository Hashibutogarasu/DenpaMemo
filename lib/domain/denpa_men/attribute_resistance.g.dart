// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'attribute_resistance.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_AttributeResistance _$AttributeResistanceFromJson(Map<String, dynamic> json) =>
    _AttributeResistance(
      attribute: Attribute.fromJson(json['attribute'] as Map<String, dynamic>),
      value: (json['value'] as num).toInt(),
    );

Map<String, dynamic> _$AttributeResistanceToJson(
  _AttributeResistance instance,
) => <String, dynamic>{
  'attribute': instance.attribute,
  'value': instance.value,
};
