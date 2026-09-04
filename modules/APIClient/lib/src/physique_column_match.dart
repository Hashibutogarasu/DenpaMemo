import 'package:freezed_annotation/freezed_annotation.dart';

part 'physique_column_match.freezed.dart';
part 'physique_column_match.g.dart';

/// One matching column found by `GET /tables/search`, as returned by
/// `findEvasionRateMatches` on `modules/server`. `columnIndex` is a raw
/// column position within `level`/`anntenaCategory`/`lineOffset`'s row —
/// translating it to a physique label (e.g. "最大") is not done here.
@freezed
abstract class PhysiqueColumnMatch with _$PhysiqueColumnMatch {
  const factory PhysiqueColumnMatch({
    required String level,
    required String anntenaCategory,
    required int lineOffset,
    required int columnIndex,
  }) = _PhysiqueColumnMatch;

  factory PhysiqueColumnMatch.fromJson(Map<String, dynamic> json) =>
      _$PhysiqueColumnMatchFromJson(json);
}
