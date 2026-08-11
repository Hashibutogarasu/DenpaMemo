// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'anntena.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Anntena _$AnntenaFromJson(Map<String, dynamic> json) => _Anntena(
  id: json['id'] as String,
  category: $enumDecode(_$AnntenaCategoryEnumMap, json['category']),
  targetCount: (json['targetCount'] as num?)?.toInt(),
  targetsAll: json['targetsAll'] as bool? ?? false,
  dealsDamage: json['dealsDamage'] as bool? ?? false,
  attackAttributeId: json['attackAttributeId'] as String?,
  isInheritable: json['isInheritable'] as bool? ?? false,
  evolvesToId: json['evolvesToId'] as String?,
  maxLevel: (json['maxLevel'] as num?)?.toInt(),
  variantGroupId: json['variantGroupId'] as String?,
);

Map<String, dynamic> _$AnntenaToJson(_Anntena instance) => <String, dynamic>{
  'id': instance.id,
  'category': _$AnntenaCategoryEnumMap[instance.category]!,
  'targetCount': instance.targetCount,
  'targetsAll': instance.targetsAll,
  'dealsDamage': instance.dealsDamage,
  'attackAttributeId': instance.attackAttributeId,
  'isInheritable': instance.isInheritable,
  'evolvesToId': instance.evolvesToId,
  'maxLevel': instance.maxLevel,
  'variantGroupId': instance.variantGroupId,
};

const _$AnntenaCategoryEnumMap = {
  AnntenaCategory.attack: 'attack',
  AnntenaCategory.support: 'support',
  AnntenaCategory.other: 'other',
};
