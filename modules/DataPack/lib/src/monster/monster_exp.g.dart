// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'monster_exp.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_MonsterExp _$MonsterExpFromJson(Map<String, dynamic> json) => _MonsterExp(
  monsterId: json['monsterId'] as String,
  count: (json['count'] as num).toInt(),
  exp: (json['exp'] as num).toInt(),
  level: (json['level'] as num).toInt(),
  maxLevelTeammateCount: (json['maxLevelTeammateCount'] as num).toInt(),
  expRecipientCount: (json['expRecipientCount'] as num).toInt(),
);

Map<String, dynamic> _$MonsterExpToJson(_MonsterExp instance) =>
    <String, dynamic>{
      'monsterId': instance.monsterId,
      'count': instance.count,
      'exp': instance.exp,
      'level': instance.level,
      'maxLevelTeammateCount': instance.maxLevelTeammateCount,
      'expRecipientCount': instance.expRecipientCount,
    };
