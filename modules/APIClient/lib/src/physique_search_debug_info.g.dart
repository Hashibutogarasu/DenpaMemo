// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'physique_search_debug_info.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_PhysiqueSearchDebugInfo _$PhysiqueSearchDebugInfoFromJson(
  Map<String, dynamic> json,
) => _PhysiqueSearchDebugInfo(
  query: json['query'] as Map<String, dynamic>,
  primaryRows: json['primaryRows'] as List<dynamic>,
  targetRows: json['targetRows'] as List<dynamic>,
  matches: json['matches'] as List<dynamic>,
  categoryRows: json['categoryRows'] as List<dynamic>,
);

Map<String, dynamic> _$PhysiqueSearchDebugInfoToJson(
  _PhysiqueSearchDebugInfo instance,
) => <String, dynamic>{
  'query': instance.query,
  'primaryRows': instance.primaryRows,
  'targetRows': instance.targetRows,
  'matches': instance.matches,
  'categoryRows': instance.categoryRows,
};
