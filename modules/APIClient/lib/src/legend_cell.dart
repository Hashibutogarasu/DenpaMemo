import 'package:freezed_annotation/freezed_annotation.dart';

import 'evasion_rate_sign.dart';

part 'legend_cell.freezed.dart';
part 'legend_cell.g.dart';

/// One physique-category legend entry for a `columnIndex`, from
/// `GET /tables/legend-grid`. `liveValues` holds every real evasion-rate
/// value (from the level/antenna's actual evasion-rate table) that falls
/// within `[evasionRateStart, evasionRateEnd]` at this `columnIndex` —
/// empty when this legend entry has no real value it applies to.
/// `isMatch` is true only for the one cell that a physique-identification
/// search actually matched.
@freezed
abstract class LegendCell with _$LegendCell {
  const factory LegendCell({
    required String categoryId,
    required int evasionRateStart,
    required int evasionRateEnd,
    required int columnIndex,
    required String textKey,
    String? text,
    EvasionRateSign? sign,
    required List<int> liveValues,
    required bool isMatch,
  }) = _LegendCell;

  factory LegendCell.fromJson(Map<String, dynamic> json) =>
      _$LegendCellFromJson(json);
}
