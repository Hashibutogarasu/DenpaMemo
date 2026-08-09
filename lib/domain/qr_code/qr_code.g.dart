// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'qr_code.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_QrCode _$QrCodeFromJson(Map<String, dynamic> json) => _QrCode(
  id: json['id'] as String,
  rawValue: json['rawValue'] as String,
  hash: json['hash'] as String,
  createdAt: DateTime.parse(json['createdAt'] as String),
  name: json['name'] as String?,
);

Map<String, dynamic> _$QrCodeToJson(_QrCode instance) => <String, dynamic>{
  'id': instance.id,
  'rawValue': instance.rawValue,
  'hash': instance.hash,
  'createdAt': instance.createdAt.toIso8601String(),
  'name': instance.name,
};
