import '../master_data/master_data.dart';
import 'abnormality_resistance.dart';
import 'attribute_resistance_calculator.dart' show BodyColorSelection;

/// Derives the [AbnormalityResistance] list a body color selection grants
/// from [masterData]'s body color abnormality resistance rules. Unlike
/// attribute resistance, every color's own bonus is simply summed: a
/// same-color pair (e.g. red + red) adds its bonus twice, and distinct
/// colors are never halved or reduced.
extension ColorAbnormalityResistanceCalculation on BodyColorSelection {
  List<AbnormalityResistance> calculateColorAbnormalityResistance(
    MasterData masterData,
  ) {
    final rulesByColorId = {
      for (final rule in masterData.bodyColorAbnormalityResistanceRules)
        rule.colorId: rule,
    };

    final totals = <String, int>{};
    for (final colorId in bodyColors) {
      final rule = rulesByColorId[colorId];
      if (rule == null) continue;
      rule.abnormalityResistanceBonuses.forEach((abnormalityId, bonus) {
        totals[abnormalityId] = (totals[abnormalityId] ?? 0) + bonus;
      });
    }

    return [
      for (final entry in totals.entries)
        AbnormalityResistance(abnormalityId: entry.key, value: entry.value),
    ];
  }
}
