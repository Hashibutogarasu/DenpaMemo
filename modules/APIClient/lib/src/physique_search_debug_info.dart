import 'package:freezed_annotation/freezed_annotation.dart';

part 'physique_search_debug_info.freezed.dart';
part 'physique_search_debug_info.g.dart';

/// The raw data `GET /tables/search` traced through to resolve its
/// `matches` — present only when the search couldn't resolve a physique
/// category, so a developer can see why (e.g. an evasionRate boundary
/// not covered by any `physique_evasion_rate_category` row) without
/// server-log access. Fields are left loosely typed since this is a
/// debug-only dump, not a stable API contract.
@freezed
abstract class PhysiqueSearchDebugInfo with _$PhysiqueSearchDebugInfo {
  const factory PhysiqueSearchDebugInfo({
    required Map<String, dynamic> query,
    required List<dynamic> primaryRows,
    required List<dynamic> targetRows,
    required List<dynamic> matches,
    required List<dynamic> categoryRows,
  }) = _PhysiqueSearchDebugInfo;

  factory PhysiqueSearchDebugInfo.fromJson(Map<String, dynamic> json) =>
      _$PhysiqueSearchDebugInfoFromJson(json);
}
