// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'anntena.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Anntena _$AnntenaFromJson(Map<String, dynamic> json) => _Anntena(
  id: json['id'] as String,
  targetCount: (json['targetCount'] as num?)?.toInt(),
  dealsDamage: json['dealsDamage'] as bool? ?? false,
  attackAttributeId: json['attackAttributeId'] as String?,
  isInheritable: json['isInheritable'] as bool? ?? false,
  evolvesToId: json['evolvesToId'] as String?,
);

Map<String, dynamic> _$AnntenaToJson(_Anntena instance) => <String, dynamic>{
  'id': instance.id,
  'targetCount': instance.targetCount,
  'dealsDamage': instance.dealsDamage,
  'attackAttributeId': instance.attackAttributeId,
  'isInheritable': instance.isInheritable,
  'evolvesToId': instance.evolvesToId,
};
