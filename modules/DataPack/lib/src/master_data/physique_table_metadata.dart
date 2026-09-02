import 'package:freezed_annotation/freezed_annotation.dart';

import 'physique_antenna_category.dart';

part 'physique_table_metadata.freezed.dart';
part 'physique_table_metadata.g.dart';

/// Everything the physique table editor needs before it can render a
/// picker or a row: the category/antenna picker options, and the current
/// column count (`values.length`) new rows are written with — sourced
/// from the server's `MasterData.physiqueTableColumnCount`, not a
/// client-side constant.
@freezed
abstract class PhysiqueTableMetadata with _$PhysiqueTableMetadata {
  const factory PhysiqueTableMetadata({
    required List<PhysiqueAntennaCategory> physiqueAntennaCategories,
    required int physiqueTableColumnCount,
  }) = _PhysiqueTableMetadata;

  factory PhysiqueTableMetadata.fromJson(Map<String, dynamic> json) =>
      _$PhysiqueTableMetadataFromJson(json);
}
