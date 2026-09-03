// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'table_definition.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_TableDefinition _$TableDefinitionFromJson(Map<String, dynamic> json) =>
    _TableDefinition(
      type: json['type'] as String,
      columnCount: (json['columnCount'] as num).toInt(),
      translationKey: json['translationKey'] as String,
    );

Map<String, dynamic> _$TableDefinitionToJson(_TableDefinition instance) =>
    <String, dynamic>{
      'type': instance.type,
      'columnCount': instance.columnCount,
      'translationKey': instance.translationKey,
    };
