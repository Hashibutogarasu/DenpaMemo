import 'package:freezed_annotation/freezed_annotation.dart';

part 'hp_cell.freezed.dart';
part 'hp_cell.g.dart';

/// One HP-table value at a `(lineOffset, columnIndex)` position, from
/// `GET /tables/legend-grid`. `isMatch` is true only for the one cell
/// that a physique-identification search actually matched.
@freezed
abstract class HpCell with _$HpCell {
  const factory HpCell({
    required int columnIndex,
    required int lineOffset,
    required num value,
    required bool isMatch,
  }) = _HpCell;

  factory HpCell.fromJson(Map<String, dynamic> json) => _$HpCellFromJson(json);
}
