// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'physique_table_record.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_PhysiqueTableRecord _$PhysiqueTableRecordFromJson(Map<String, dynamic> json) =>
    _PhysiqueTableRecord(
      statusCategory: json['statusCategory'] as String,
      level: json['level'] as String,
      anntenaCategory: json['anntenaCategory'] as String,
      lineOffset: (json['lineOffset'] as num).toInt(),
      values: (json['values'] as List<dynamic>)
          .map((e) => (e as num).toInt())
          .toList(),
    );

Map<String, dynamic> _$PhysiqueTableRecordToJson(
  _PhysiqueTableRecord instance,
) => <String, dynamic>{
  'statusCategory': instance.statusCategory,
  'level': instance.level,
  'anntenaCategory': instance.anntenaCategory,
  'lineOffset': instance.lineOffset,
  'values': instance.values,
};
