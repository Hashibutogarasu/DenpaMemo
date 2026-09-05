import 'package:freezed_annotation/freezed_annotation.dart';

import 'physique_column_match.dart';
import 'physique_search_debug_info.dart';

part 'physique_search_result.freezed.dart';
part 'physique_search_result.g.dart';

/// The full response of `GET /tables/search`: [matches] plus, only when
/// the search couldn't resolve a physique category, a [info] dump of
/// the data it traced through to explain why.
@freezed
abstract class PhysiqueSearchResult with _$PhysiqueSearchResult {
  const factory PhysiqueSearchResult({
    required List<PhysiqueColumnMatch> matches,
    PhysiqueSearchDebugInfo? info,
  }) = _PhysiqueSearchResult;

  factory PhysiqueSearchResult.fromJson(Map<String, dynamic> json) =>
      _$PhysiqueSearchResultFromJson(json);
}
