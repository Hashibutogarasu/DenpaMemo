// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'physique_column_search_query.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_PhysiqueColumnSearchQuery _$PhysiqueColumnSearchQueryFromJson(
  Map<String, dynamic> json,
) => _PhysiqueColumnSearchQuery(
  type: json['type'] as String,
  against: json['against'] as String,
  evasionRate: (json['evasionRate'] as num).toInt(),
  hp: (json['hp'] as num).toInt(),
  level: json['level'] as String?,
  anntenaCategory: json['anntenaCategory'] as String?,
  antenna: json['antenna'] as String?,
);

Map<String, dynamic> _$PhysiqueColumnSearchQueryToJson(
  _PhysiqueColumnSearchQuery instance,
) => <String, dynamic>{
  'type': instance.type,
  'against': instance.against,
  'evasionRate': instance.evasionRate,
  'hp': instance.hp,
  'level': instance.level,
  'anntenaCategory': instance.anntenaCategory,
  'antenna': instance.antenna,
};
