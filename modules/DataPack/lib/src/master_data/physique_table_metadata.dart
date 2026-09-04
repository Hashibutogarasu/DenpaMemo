import 'package:freezed_annotation/freezed_annotation.dart';

import 'physique_antenna_category.dart';
import 'physique_antenna_category_antenna_link.dart';
import 'physique_status_category.dart';

part 'physique_table_metadata.freezed.dart';
part 'physique_table_metadata.g.dart';

/// Everything the physique table editor needs before it can render a
/// picker or a row: the antenna category picker options and the status
/// category picker options (each carrying its own row width). Sourced
/// from the server's `MasterData`, not client-side constants.
@freezed
abstract class PhysiqueTableMetadata with _$PhysiqueTableMetadata {
  const factory PhysiqueTableMetadata({
    required List<PhysiqueAntennaCategory> physiqueAntennaCategories,
    required List<PhysiqueStatusCategory> physiqueStatusCategories,
    required List<PhysiqueAntennaCategoryAntennaLink>
    physiqueAntennaCategoryAntennaLinks,
  }) = _PhysiqueTableMetadata;

  factory PhysiqueTableMetadata.fromJson(Map<String, dynamic> json) =>
      _$PhysiqueTableMetadataFromJson(json);
}
