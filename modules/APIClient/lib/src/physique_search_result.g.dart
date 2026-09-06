// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'physique_search_result.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_PhysiqueSearchResult _$PhysiqueSearchResultFromJson(
  Map<String, dynamic> json,
) => _PhysiqueSearchResult(
  matches: (json['matches'] as List<dynamic>)
      .map((e) => PhysiqueColumnMatch.fromJson(e as Map<String, dynamic>))
      .toList(),
  info: json['info'] == null
      ? null
      : PhysiqueSearchDebugInfo.fromJson(json['info'] as Map<String, dynamic>),
);

Map<String, dynamic> _$PhysiqueSearchResultToJson(
  _PhysiqueSearchResult instance,
) => <String, dynamic>{'matches': instance.matches, 'info': instance.info};
