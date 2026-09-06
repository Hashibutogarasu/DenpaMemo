import 'package:freezed_annotation/freezed_annotation.dart';

part 'physique_column_search_query.freezed.dart';
part 'physique_column_search_query.g.dart';

/// The query parameters `GET /tables/search` accepts, matching
/// `searchTablesQuerySchema` on the server. [PhysiquesApiClient.search]
/// builds the HTTP request's query string from [toJson], so a field added
/// here only needs to also be added server-side, never hand-mapped again
/// on the client.
@freezed
abstract class PhysiqueColumnSearchQuery with _$PhysiqueColumnSearchQuery {
  const factory PhysiqueColumnSearchQuery({
    required String type,
    required String against,
    required int evasionRate,
    required int hp,
    String? level,
    String? anntenaCategory,
    String? antenna,
  }) = _PhysiqueColumnSearchQuery;

  factory PhysiqueColumnSearchQuery.fromJson(Map<String, dynamic> json) =>
      _$PhysiqueColumnSearchQueryFromJson(json);
}
