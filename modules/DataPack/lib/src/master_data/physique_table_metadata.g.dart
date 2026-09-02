// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'physique_table_metadata.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_PhysiqueTableMetadata _$PhysiqueTableMetadataFromJson(
  Map<String, dynamic> json,
) => _PhysiqueTableMetadata(
  physiqueAntennaCategories:
      (json['physiqueAntennaCategories'] as List<dynamic>)
          .map(
            (e) => PhysiqueAntennaCategory.fromJson(e as Map<String, dynamic>),
          )
          .toList(),
  physiqueStatusCategories: (json['physiqueStatusCategories'] as List<dynamic>)
      .map((e) => PhysiqueStatusCategory.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$PhysiqueTableMetadataToJson(
  _PhysiqueTableMetadata instance,
) => <String, dynamic>{
  'physiqueAntennaCategories': instance.physiqueAntennaCategories,
  'physiqueStatusCategories': instance.physiqueStatusCategories,
};
