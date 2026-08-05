// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'head_shape.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_HeadShape _$HeadShapeFromJson(Map<String, dynamic> json) => _HeadShape(
  id: json['id'] as String,
  displayName: json['displayName'] as String,
  abnormalityResistanceBonuses:
      (json['abnormalityResistanceBonuses'] as Map<String, dynamic>?)?.map(
        (k, e) => MapEntry(k, (e as num).toInt()),
      ) ??
      const {},
);

Map<String, dynamic> _$HeadShapeToJson(_HeadShape instance) =>
    <String, dynamic>{
      'id': instance.id,
      'displayName': instance.displayName,
      'abnormalityResistanceBonuses': instance.abnormalityResistanceBonuses,
    };
