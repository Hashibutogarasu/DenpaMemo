// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hp_cell.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_HpCell _$HpCellFromJson(Map<String, dynamic> json) => _HpCell(
  columnIndex: (json['columnIndex'] as num).toInt(),
  lineOffset: (json['lineOffset'] as num).toInt(),
  value: json['value'] as num,
  isMatch: json['isMatch'] as bool,
);

Map<String, dynamic> _$HpCellToJson(_HpCell instance) => <String, dynamic>{
  'columnIndex': instance.columnIndex,
  'lineOffset': instance.lineOffset,
  'value': instance.value,
  'isMatch': instance.isMatch,
};
