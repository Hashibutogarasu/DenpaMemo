import 'package:freezed_annotation/freezed_annotation.dart';

import 'attribute_bonus.dart';

part 'body_color_resistance_rule.freezed.dart';
part 'body_color_resistance_rule.g.dart';

/// Per-color attribute resistance rule, loaded from
/// `assets/data/body_color_attribute_resistance.json`.
///
/// [attributeResistanceBonuses] is resolved from the source JSON's
/// `{attributeId: bonus}` map by [JsonMasterDataRepository], not
/// deserialized directly.
@freezed
abstract class BodyColorResistanceRule with _$BodyColorResistanceRule {
  const factory BodyColorResistanceRule({
    required String colorId,
    @JsonKey(includeFromJson: false, includeToJson: false)
    @Default(<AttributeBonus>[])
    List<AttributeBonus> attributeResistanceBonuses,
  }) = _BodyColorResistanceRule;

  factory BodyColorResistanceRule.fromJson(Map<String, dynamic> json) =>
      _$BodyColorResistanceRuleFromJson(json);
}
