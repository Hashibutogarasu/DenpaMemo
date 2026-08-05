import 'package:freezed_annotation/freezed_annotation.dart';

part 'head_shape.freezed.dart';
part 'head_shape.g.dart';

/// Head shape master data entry, loaded from `assets/data/head_shapes.json`.
@freezed
abstract class HeadShape with _$HeadShape {
  const factory HeadShape({
    required String id,
    required String displayName,
    @Default({}) Map<String, int> abnormalityResistanceBonuses,
  }) = _HeadShape;

  factory HeadShape.fromJson(Map<String, dynamic> json) =>
      _$HeadShapeFromJson(json);
}
