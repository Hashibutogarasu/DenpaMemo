// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'denpa_men.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_DenpaMen _$DenpaMenFromJson(Map<String, dynamic> json) => _DenpaMen(
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
);

Map<String, dynamic> _$DenpaMenToJson(_DenpaMen instance) => <String, dynamic>{
  'abnormalityResistances': instance.abnormalityResistances,
  'bodyColors': instance.bodyColors,
  'attributeResistance': instance.attributeResistance,
  'physique': instance.physique,
  'personality': instance.personality,
  'pattern': instance.pattern,
  'headShape': instance.headShape,
  'anntena': instance.anntena,
  'isSpColor': instance.isSpColor,
};
