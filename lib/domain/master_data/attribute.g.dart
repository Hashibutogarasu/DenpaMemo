// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'attribute.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Attribute _$AttributeFromJson(Map<String, dynamic> json) => _Attribute(
  id: json['id'] as String,
  displayName: json['displayName'] as String,
  index: (json['index'] as num).toInt(),
);

Map<String, dynamic> _$AttributeToJson(_Attribute instance) =>
    <String, dynamic>{
      'id': instance.id,
      'displayName': instance.displayName,
      'index': instance.index,
    };
