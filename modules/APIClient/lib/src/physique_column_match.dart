import 'package:freezed_annotation/freezed_annotation.dart';

part 'physique_column_match.freezed.dart';
part 'physique_column_match.g.dart';

/// One matching column found by `GET /tables/search`, as returned by
/// `findEvasionRateMatches` on `modules/server`. `columnIndex` is a raw
/// column position within `level`/`anntenaCategory`/`lineOffset`'s row.
/// `textKey` is the physique category id (e.g. `largest`), usable
/// directly as a `Physique.id`; `text` is that key already translated
/// server-side for the request's `Accept-Language`. Either can be `null`
/// if the server has no matching category pattern for this column.
@freezed
abstract class PhysiqueColumnMatch with _$PhysiqueColumnMatch {
  const factory PhysiqueColumnMatch({
    required String level,
    required String anntenaCategory,
    required int lineOffset,
    required int columnIndex,
    String? textKey,
    String? text,
  }) = _PhysiqueColumnMatch;

  factory PhysiqueColumnMatch.fromJson(Map<String, dynamic> json) =>
      _$PhysiqueColumnMatchFromJson(json);
}
