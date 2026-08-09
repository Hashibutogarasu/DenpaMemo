// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'denpa_men.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_DenpaMen _$DenpaMenFromJson(Map<String, dynamic> json) => _DenpaMen(
  id: json['id'] as String,
  name: json['name'] as String,
  abnormalityResistances: (json['abnormalityResistances'] as List<dynamic>)
      .map((e) => AbnormalityResistance.fromJson(e as Map<String, dynamic>))
      .toList(),
  bodyColors: (json['bodyColors'] as List<dynamic>)
      .map((e) => e as String)
      .toList(),
  attributeResistance: (json['attributeResistance'] as List<dynamic>)
      .map((e) => AttributeResistance.fromJson(e as Map<String, dynamic>))
      .toList(),
  physique: Physique.fromJson(json['physique'] as Map<String, dynamic>),
  personality: Personality.fromJson(
    json['personality'] as Map<String, dynamic>,
  ),
  pattern: Pattern.fromJson(json['pattern'] as Map<String, dynamic>),
  headShape: HeadShape.fromJson(json['headShape'] as Map<String, dynamic>),
  anntena: Anntena.fromJson(json['anntena'] as Map<String, dynamic>),
  isSpColor: json['isSpColor'] as bool,
  happiness: (json['happiness'] as num).toInt(),
  maxHappiness: (json['maxHappiness'] as num).toInt(),
  level: (json['level'] as num).toInt(),
  maxLevel: (json['maxLevel'] as num).toInt(),
  currentExp: (json['currentExp'] as num?)?.toInt(),
  maxExp: (json['maxExp'] as num?)?.toInt(),
  hp: (json['hp'] as num).toInt(),
  ap: (json['ap'] as num).toInt(),
  attack: (json['attack'] as num).toInt(),
  defense: (json['defense'] as num).toInt(),
  speed: (json['speed'] as num).toInt(),
  evasionRate: (json['evasionRate'] as num).toInt(),
  corrections: (json['corrections'] as List<dynamic>)
      .map((e) => Correction.fromJson(e as Map<String, dynamic>))
      .toList(),
  parentIds: (json['parentIds'] as List<dynamic>)
      .map((e) => e as String)
      .toList(),
  memo: json['memo'] as String?,
  moveInDate: json['moveInDate'] == null
      ? null
      : DateTime.parse(json['moveInDate'] as String),
);

Map<String, dynamic> _$DenpaMenToJson(_DenpaMen instance) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'abnormalityResistances': instance.abnormalityResistances,
  'bodyColors': instance.bodyColors,
  'attributeResistance': instance.attributeResistance,
  'physique': instance.physique,
  'personality': instance.personality,
  'pattern': instance.pattern,
  'headShape': instance.headShape,
  'anntena': instance.anntena,
  'isSpColor': instance.isSpColor,
  'happiness': instance.happiness,
  'maxHappiness': instance.maxHappiness,
  'level': instance.level,
  'maxLevel': instance.maxLevel,
  'currentExp': instance.currentExp,
  'maxExp': instance.maxExp,
  'hp': instance.hp,
  'ap': instance.ap,
  'attack': instance.attack,
  'defense': instance.defense,
  'speed': instance.speed,
  'evasionRate': instance.evasionRate,
  'corrections': instance.corrections,
  'parentIds': instance.parentIds,
  'memo': instance.memo,
  'moveInDate': instance.moveInDate?.toIso8601String(),
};
