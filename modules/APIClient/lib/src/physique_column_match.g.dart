// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'physique_column_match.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_PhysiqueColumnMatch _$PhysiqueColumnMatchFromJson(Map<String, dynamic> json) =>
    _PhysiqueColumnMatch(
      level: json['level'] as String,
      anntenaCategory: json['anntenaCategory'] as String,
      lineOffset: (json['lineOffset'] as num).toInt(),
      columnIndex: (json['columnIndex'] as num).toInt(),
      textKey: json['textKey'] as String?,
      text: json['text'] as String?,
    );

Map<String, dynamic> _$PhysiqueColumnMatchToJson(
  _PhysiqueColumnMatch instance,
) => <String, dynamic>{
  'level': instance.level,
  'anntenaCategory': instance.anntenaCategory,
  'lineOffset': instance.lineOffset,
  'columnIndex': instance.columnIndex,
  'textKey': instance.textKey,
  'text': instance.text,
};
