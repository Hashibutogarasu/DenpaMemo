// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'qr_code.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_QRCode _$QRCodeFromJson(Map<String, dynamic> json) => _QRCode(
  rawString: json['rawString'] as String,
  denpaMens:
      (json['denpaMens'] as List<dynamic>?)
          ?.map((e) => DenpaMen.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
  memo: json['memo'] as String?,
  createdAt: DateTime.parse(json['createdAt'] as String),
  updatedAt: json['updatedAt'] == null
      ? null
      : DateTime.parse(json['updatedAt'] as String),
  deletedAt: json['deletedAt'] == null
      ? null
      : DateTime.parse(json['deletedAt'] as String),
);

Map<String, dynamic> _$QRCodeToJson(_QRCode instance) => <String, dynamic>{
  'rawString': instance.rawString,
  'denpaMens': instance.denpaMens,
  'memo': instance.memo,
  'createdAt': instance.createdAt.toIso8601String(),
  'updatedAt': instance.updatedAt?.toIso8601String(),
  'deletedAt': instance.deletedAt?.toIso8601String(),
};
