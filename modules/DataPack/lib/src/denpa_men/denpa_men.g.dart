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
  bodyColorShades:
      (json['bodyColorShades'] as List<dynamic>?)
          ?.map((e) => (e as num).toInt())
          .toList() ??
      const <int>[],
  attributeResistance: (json['attributeResistance'] as List<dynamic>)
      .map((e) => AttributeResistance.fromJson(e as Map<String, dynamic>))
      .toList(),
  physique: Physique.fromJson(json['physique'] as Map<String, dynamic>),
  physiqueColumnIndex: (json['physiqueColumnIndex'] as num?)?.toInt(),
  personality: Personality.fromJson(
    json['personality'] as Map<String, dynamic>,
  ),
  pattern: Pattern.fromJson(json['pattern'] as Map<String, dynamic>),
  headShape: HeadShape.fromJson(json['headShape'] as Map<String, dynamic>),
  anntena: Anntena.fromJson(json['anntena'] as Map<String, dynamic>),
  antennaLevel: (json['antennaLevel'] as num?)?.toInt() ?? 0,
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
  considerCorrections: json['considerCorrections'] as bool,
  parentIds: (json['parentIds'] as List<dynamic>)
      .map((e) => e as String)
      .toList(),
  catchOrder: (json['catchOrder'] as num?)?.toInt(),
  qrCodeId: json['qrCodeId'] as String?,
  memo: json['memo'] as String?,
  moveInDate: json['moveInDate'] == null
      ? null
      : DateTime.parse(json['moveInDate'] as String),
  hash: json['hash'] as String? ?? '',
  monsterExp: json['monsterExp'] == null
      ? null
      : MonsterExp.fromJson(json['monsterExp'] as Map<String, dynamic>),
);

Map<String, dynamic> _$DenpaMenToJson(_DenpaMen instance) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'abnormalityResistances': instance.abnormalityResistances,
  'bodyColors': instance.bodyColors,
  'bodyColorShades': instance.bodyColorShades,
  'attributeResistance': instance.attributeResistance,
  'physique': instance.physique,
  'physiqueColumnIndex': instance.physiqueColumnIndex,
  'personality': instance.personality,
  'pattern': instance.pattern,
  'headShape': instance.headShape,
  'anntena': instance.anntena,
  'antennaLevel': instance.antennaLevel,
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
  'considerCorrections': instance.considerCorrections,
  'parentIds': instance.parentIds,
  'catchOrder': instance.catchOrder,
  'qrCodeId': instance.qrCodeId,
  'memo': instance.memo,
  'moveInDate': instance.moveInDate?.toIso8601String(),
  'hash': instance.hash,
  'monsterExp': instance.monsterExp,
};
