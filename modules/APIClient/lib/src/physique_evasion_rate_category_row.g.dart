// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'physique_evasion_rate_category_row.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_PhysiqueEvasionRateCategoryRow _$PhysiqueEvasionRateCategoryRowFromJson(
  Map<String, dynamic> json,
) => _PhysiqueEvasionRateCategoryRow(
  id: json['id'] as String,
  evasionRateStart: (json['evasionRateStart'] as num).toInt(),
  evasionRateEnd: (json['evasionRateEnd'] as num).toInt(),
  columnIndex: (json['columnIndex'] as num).toInt(),
  textKey: json['textKey'] as String,
  sign: $enumDecodeNullable(_$EvasionRateSignEnumMap, json['sign']),
);

Map<String, dynamic> _$PhysiqueEvasionRateCategoryRowToJson(
  _PhysiqueEvasionRateCategoryRow instance,
) => <String, dynamic>{
  'id': instance.id,
  'evasionRateStart': instance.evasionRateStart,
  'evasionRateEnd': instance.evasionRateEnd,
  'columnIndex': instance.columnIndex,
  'textKey': instance.textKey,
  'sign': _$EvasionRateSignEnumMap[instance.sign],
};

const _$EvasionRateSignEnumMap = {
  EvasionRateSign.plus: 'plus',
  EvasionRateSign.minus: 'minus',
};
