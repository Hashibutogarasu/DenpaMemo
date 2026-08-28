// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'abnormality_resistance.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_AbnormalityResistance _$AbnormalityResistanceFromJson(
  Map<String, dynamic> json,
) => _AbnormalityResistance(
  abnormalityId: json['abnormalityId'] as String,
  value: (json['value'] as num).toInt(),
);

Map<String, dynamic> _$AbnormalityResistanceToJson(
  _AbnormalityResistance instance,
) => <String, dynamic>{
  'abnormalityId': instance.abnormalityId,
  'value': instance.value,
};
