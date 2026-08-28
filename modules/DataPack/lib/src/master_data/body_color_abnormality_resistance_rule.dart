import 'package:freezed_annotation/freezed_annotation.dart';

part 'body_color_abnormality_resistance_rule.freezed.dart';
part 'body_color_abnormality_resistance_rule.g.dart';

/// Per-color abnormality resistance rule, loaded from
/// `assets/data/body_color_abnormality_resistance.json`.
@freezed
abstract class BodyColorAbnormalityResistanceRule
    with _$BodyColorAbnormalityResistanceRule {
  const factory BodyColorAbnormalityResistanceRule({
    required String colorId,
    @Default({}) Map<String, int> abnormalityResistanceBonuses,
  }) = _BodyColorAbnormalityResistanceRule;

  factory BodyColorAbnormalityResistanceRule.fromJson(
    Map<String, dynamic> json,
  ) => _$BodyColorAbnormalityResistanceRuleFromJson(json);
}
