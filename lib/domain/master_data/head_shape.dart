import 'package:freezed_annotation/freezed_annotation.dart';

import 'attribute_bonus.dart';

part 'head_shape.freezed.dart';
part 'head_shape.g.dart';

/// Head shape master data entry, loaded from `assets/data/head_shapes/*.json`
/// (one file per head shape).
///
/// [attributeResistanceBonuses] is resolved from the source JSON's
/// `{attributeId: bonus}` map by [JsonMasterDataRepository], not
/// deserialized directly.
@freezed
abstract class HeadShape with _$HeadShape {
  const factory HeadShape({
    required String id,
    @Default({}) Map<String, int> abnormalityResistanceBonuses,
    @JsonKey(includeFromJson: false, includeToJson: false)
    @Default(<AttributeBonus>[])
    List<AttributeBonus> attributeResistanceBonuses,
    @Default(0) int hpBonus,
    @Default(0) int apBonus,
    @Default(0) int attackBonus,
    @Default(0) int defenseBonus,
    @Default(0) int speedBonus,
    @Default(0) int evasionRateBonus,
  }) = _HeadShape;

  factory HeadShape.fromJson(Map<String, dynamic> json) =>
      _$HeadShapeFromJson(json);
}
