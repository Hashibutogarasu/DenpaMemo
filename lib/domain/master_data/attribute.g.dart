// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'attribute.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Attribute _$AttributeFromJson(Map<String, dynamic> json) => _Attribute(
  id: json['id'] as String,
  index: (json['index'] as num).toInt(),
  isElemental: json['isElemental'] as bool? ?? true,
  resistantTo:
      (json['resistantTo'] as List<dynamic>?)
          ?.map((e) => Attribute.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const <Attribute>[],
  weakTo:
      (json['weakTo'] as List<dynamic>?)
          ?.map((e) => Attribute.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const <Attribute>[],
);

Map<String, dynamic> _$AttributeToJson(_Attribute instance) =>
    <String, dynamic>{
      'id': instance.id,
      'index': instance.index,
      'isElemental': instance.isElemental,
      'resistantTo': instance.resistantTo,
      'weakTo': instance.weakTo,
    };
