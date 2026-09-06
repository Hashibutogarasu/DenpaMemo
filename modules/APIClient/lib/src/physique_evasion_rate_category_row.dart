import 'package:freezed_annotation/freezed_annotation.dart';

import 'evasion_rate_sign.dart';

part 'physique_evasion_rate_category_row.freezed.dart';
part 'physique_evasion_rate_category_row.g.dart';

/// One raw row of `GET /tables/evasion-rate-categories`: an untranslated
/// physique-category legend definition (`physique_evasion_rate_category`
/// on the server), cached locally so identification can run offline.
@freezed
abstract class PhysiqueEvasionRateCategoryRow with _$PhysiqueEvasionRateCategoryRow {
  const factory PhysiqueEvasionRateCategoryRow({
    required String id,
    required int evasionRateStart,
    required int evasionRateEnd,
    required int columnIndex,
    required String textKey,
    EvasionRateSign? sign,
  }) = _PhysiqueEvasionRateCategoryRow;

  factory PhysiqueEvasionRateCategoryRow.fromJson(Map<String, dynamic> json) =>
      _$PhysiqueEvasionRateCategoryRowFromJson(json);
}
