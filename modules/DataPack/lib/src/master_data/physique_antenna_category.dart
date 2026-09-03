import 'package:freezed_annotation/freezed_annotation.dart';

part 'physique_antenna_category.freezed.dart';
part 'physique_antenna_category.g.dart';

/// One row of the physique table category picker: an antenna name
/// (`anntenaCategory`) grouped under a display category (`category`).
/// Sourced from the server's `PhysiqueAntennaCategoryEntity`, not bundled
/// as a JSON asset.
@freezed
abstract class PhysiqueAntennaCategory with _$PhysiqueAntennaCategory {
  const factory PhysiqueAntennaCategory({
    required String category,
    required String anntenaCategory,
  }) = _PhysiqueAntennaCategory;

  factory PhysiqueAntennaCategory.fromJson(Map<String, dynamic> json) =>
      _$PhysiqueAntennaCategoryFromJson(json);
}
