// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'qr_code.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_QrCode _$QrCodeFromJson(Map<String, dynamic> json) => _QrCode(
  rawValue: json['rawValue'] as String,
  hash: json['hash'] as String,
  createdAt: DateTime.parse(json['createdAt'] as String),
);

Map<String, dynamic> _$QrCodeToJson(_QrCode instance) => <String, dynamic>{
  'rawValue': instance.rawValue,
  'hash': instance.hash,
  'createdAt': instance.createdAt.toIso8601String(),
};
