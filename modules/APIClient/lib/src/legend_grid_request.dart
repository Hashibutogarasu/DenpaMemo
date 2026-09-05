import 'package:freezed_annotation/freezed_annotation.dart';

part 'legend_grid_request.freezed.dart';
part 'legend_grid_request.g.dart';

/// The query parameters `GET /tables/legend-grid` accepts, matching
/// `legendGridQuerySchema` on the server. [PhysiquesApiClient.legendGrid]
/// builds the HTTP request's query string from [toJson].
@freezed
abstract class LegendGridRequest with _$LegendGridRequest {
  const factory LegendGridRequest({
    required String level,
    required String anntenaCategory,
    required int matchColumnIndex,
    required int matchLineOffset,
    required int matchEvasionRate,
  }) = _LegendGridRequest;

  factory LegendGridRequest.fromJson(Map<String, dynamic> json) =>
      _$LegendGridRequestFromJson(json);
}
