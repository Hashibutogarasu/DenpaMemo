import 'package:freezed_annotation/freezed_annotation.dart';

part 'body_color_resistance_rule.freezed.dart';
part 'body_color_resistance_rule.g.dart';

/// Per-color attribute resistance rule, loaded from
/// `assets/data/body_color_attribute_resistance.json`.
@freezed
abstract class BodyColorResistanceRule with _$BodyColorResistanceRule {
  const factory BodyColorResistanceRule({
    required String colorId,
    @Default({}) Map<String, int> attributeResistanceBonuses,
    String? weaknessAttributeId,
  }) = _BodyColorResistanceRule;

  factory BodyColorResistanceRule.fromJson(Map<String, dynamic> json) =>
      _$BodyColorResistanceRuleFromJson(json);
}
