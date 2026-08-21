// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'denpa_men_backup_entry.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_DenpaMenBackupEntry _$DenpaMenBackupEntryFromJson(Map<String, dynamic> json) =>
    _DenpaMenBackupEntry(
      denpaMen: DenpaMen.fromJson(json['denpaMen'] as Map<String, dynamic>),
      qrCode: json['qrCode'] == null
          ? null
          : QrCode.fromJson(json['qrCode'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$DenpaMenBackupEntryToJson(
  _DenpaMenBackupEntry instance,
) => <String, dynamic>{
  'denpaMen': instance.denpaMen,
  'qrCode': instance.qrCode,
};
