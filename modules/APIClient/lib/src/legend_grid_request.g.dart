// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'legend_grid_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_LegendGridRequest _$LegendGridRequestFromJson(Map<String, dynamic> json) =>
    _LegendGridRequest(
      level: json['level'] as String,
      anntenaCategory: json['anntenaCategory'] as String,
      matchColumnIndex: (json['matchColumnIndex'] as num).toInt(),
      matchLineOffset: (json['matchLineOffset'] as num).toInt(),
      matchEvasionRate: (json['matchEvasionRate'] as num).toInt(),
    );

Map<String, dynamic> _$LegendGridRequestToJson(_LegendGridRequest instance) =>
    <String, dynamic>{
      'level': instance.level,
      'anntenaCategory': instance.anntenaCategory,
      'matchColumnIndex': instance.matchColumnIndex,
      'matchLineOffset': instance.matchLineOffset,
      'matchEvasionRate': instance.matchEvasionRate,
    };
