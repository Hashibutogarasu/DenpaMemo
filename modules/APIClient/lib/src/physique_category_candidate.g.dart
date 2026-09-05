// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'physique_category_candidate.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_PhysiqueCategoryCandidate _$PhysiqueCategoryCandidateFromJson(
  Map<String, dynamic> json,
) => _PhysiqueCategoryCandidate(
  textKey: json['textKey'] as String,
  text: json['text'] as String?,
  sign: json['sign'] as String?,
  evasionRateStart: (json['evasionRateStart'] as num).toInt(),
  evasionRateEnd: (json['evasionRateEnd'] as num).toInt(),
);

Map<String, dynamic> _$PhysiqueCategoryCandidateToJson(
  _PhysiqueCategoryCandidate instance,
) => <String, dynamic>{
  'textKey': instance.textKey,
  'text': instance.text,
  'sign': instance.sign,
  'evasionRateStart': instance.evasionRateStart,
  'evasionRateEnd': instance.evasionRateEnd,
};
