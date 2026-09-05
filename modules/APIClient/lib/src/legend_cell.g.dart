// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'legend_cell.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_LegendCell _$LegendCellFromJson(Map<String, dynamic> json) => _LegendCell(
  categoryId: json['categoryId'] as String,
  evasionRateStart: (json['evasionRateStart'] as num).toInt(),
  evasionRateEnd: (json['evasionRateEnd'] as num).toInt(),
  columnIndex: (json['columnIndex'] as num).toInt(),
  textKey: json['textKey'] as String,
  text: json['text'] as String?,
  sign: $enumDecodeNullable(_$EvasionRateSignEnumMap, json['sign']),
  liveValues: (json['liveValues'] as List<dynamic>)
      .map((e) => (e as num).toInt())
      .toList(),
  isMatch: json['isMatch'] as bool,
);

Map<String, dynamic> _$LegendCellToJson(_LegendCell instance) =>
    <String, dynamic>{
      'categoryId': instance.categoryId,
      'evasionRateStart': instance.evasionRateStart,
      'evasionRateEnd': instance.evasionRateEnd,
      'columnIndex': instance.columnIndex,
      'textKey': instance.textKey,
      'text': instance.text,
      'sign': _$EvasionRateSignEnumMap[instance.sign],
      'liveValues': instance.liveValues,
      'isMatch': instance.isMatch,
    };

const _$EvasionRateSignEnumMap = {
  EvasionRateSign.plus: 'plus',
  EvasionRateSign.minus: 'minus',
};
