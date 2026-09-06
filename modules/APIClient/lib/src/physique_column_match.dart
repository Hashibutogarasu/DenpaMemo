import 'package:freezed_annotation/freezed_annotation.dart';

import 'physique_category_candidate.dart';

part 'physique_column_match.freezed.dart';
part 'physique_column_match.g.dart';

/// One matching column found by `GET /tables/search`, as returned by
/// `findEvasionRateMatches` on `modules/server`. `columnIndex` is a raw
/// column position within `level`/`anntenaCategory`/`lineOffset`'s row.
/// `candidates` holds every physique category the server found for this
/// column — usually one, but more than one when its category patterns
/// overlap, in which case the caller must ask the user to pick.
@freezed
abstract class PhysiqueColumnMatch with _$PhysiqueColumnMatch {
  const factory PhysiqueColumnMatch({
    required String level,
    required String anntenaCategory,
    required int lineOffset,
    required int columnIndex,
    @Default(<PhysiqueCategoryCandidate>[])
    List<PhysiqueCategoryCandidate> candidates,
  }) = _PhysiqueColumnMatch;

  factory PhysiqueColumnMatch.fromJson(Map<String, dynamic> json) =>
      _$PhysiqueColumnMatchFromJson(json);
}
