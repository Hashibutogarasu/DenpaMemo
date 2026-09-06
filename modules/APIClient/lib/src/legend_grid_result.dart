import 'package:freezed_annotation/freezed_annotation.dart';

import 'hp_cell.dart';
import 'legend_cell.dart';

part 'legend_grid_result.freezed.dart';
part 'legend_grid_result.g.dart';

/// Response of `GET /tables/legend-grid`: the physique-category legend
/// merged with real evasion-rate values, plus the HP table's values, for
/// one `level`/`anntenaCategory` pair.
@freezed
abstract class LegendGridResult with _$LegendGridResult {
  const factory LegendGridResult({
    required String level,
    required String anntenaCategory,
    required List<LegendCell> legendCells,
    required List<HpCell> hpCells,
  }) = _LegendGridResult;

  factory LegendGridResult.fromJson(Map<String, dynamic> json) =>
      _$LegendGridResultFromJson(json);
}
