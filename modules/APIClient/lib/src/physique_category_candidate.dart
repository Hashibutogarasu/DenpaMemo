import 'package:freezed_annotation/freezed_annotation.dart';

part 'physique_category_candidate.freezed.dart';
part 'physique_category_candidate.g.dart';

/// One possible physique category for a [PhysiqueColumnMatch]'s
/// `columnIndex`. More than one can apply to the same column when the
/// server's category patterns overlap — the caller must let the user
/// pick between them rather than guessing. `textKey` is the physique
/// category id (e.g. `largest`), usable directly as a `Physique.id`;
/// `text` is that key already translated server-side. `sign` is
/// `"plus"` or `"minus"` when the server's pattern for this candidate is
/// one side of an overlapping plus/minus pair, or `null` when the
/// pattern isn't split that way. `evasionRateStart`/`evasionRateEnd` are
/// the matched category row's evasion-rate range, equal when the row
/// matches a single value rather than a range.
@freezed
abstract class PhysiqueCategoryCandidate with _$PhysiqueCategoryCandidate {
  const factory PhysiqueCategoryCandidate({
    required String textKey,
    String? text,
    String? sign,
    required int evasionRateStart,
    required int evasionRateEnd,
  }) = _PhysiqueCategoryCandidate;

  factory PhysiqueCategoryCandidate.fromJson(Map<String, dynamic> json) =>
      _$PhysiqueCategoryCandidateFromJson(json);
}
