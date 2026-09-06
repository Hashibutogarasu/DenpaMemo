// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'legend_grid_result.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_LegendGridResult _$LegendGridResultFromJson(Map<String, dynamic> json) =>
    _LegendGridResult(
      level: json['level'] as String,
      anntenaCategory: json['anntenaCategory'] as String,
      legendCells: (json['legendCells'] as List<dynamic>)
          .map((e) => LegendCell.fromJson(e as Map<String, dynamic>))
          .toList(),
      hpCells: (json['hpCells'] as List<dynamic>)
          .map((e) => HpCell.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$LegendGridResultToJson(_LegendGridResult instance) =>
    <String, dynamic>{
      'level': instance.level,
      'anntenaCategory': instance.anntenaCategory,
      'legendCells': instance.legendCells,
      'hpCells': instance.hpCells,
    };
