import 'abnormality_resistance.dart';
import 'denpa_men.dart';

/// Applies a [DenpaMen]'s [DenpaMen.corrections] on top of its
/// already-calculated growth stats and abnormality resistances — the last
/// step in the pipeline, right before a [DenpaMen] is finalized.
extension DenpaMenCorrectionCalculation on DenpaMen {
  DenpaMen applyCorrections() {
    if (corrections.isEmpty) return this;

    var hpBonus = 0;
    var apBonus = 0;
    var attackBonus = 0;
    var defenseBonus = 0;
    var speedBonus = 0;
    var evasionRateBonus = 0;
    final abnormalityBonuses = <String, int>{};

    for (final correction in corrections) {
      hpBonus += correction.hpBonus;
      apBonus += correction.apBonus;
      attackBonus += correction.attackBonus;
      defenseBonus += correction.defenseBonus;
      speedBonus += correction.speedBonus;
      evasionRateBonus += correction.evasionRateBonus;
      correction.abnormalityResistanceBonuses.forEach((abnormalityId, bonus) {
        abnormalityBonuses[abnormalityId] =
            (abnormalityBonuses[abnormalityId] ?? 0) + bonus;
      });
    }

    final abnormalityTotals = <String, int>{
      for (final resistance in abnormalityResistances)
        resistance.abnormalityId: resistance.value,
    };
    abnormalityBonuses.forEach((abnormalityId, bonus) {
      abnormalityTotals[abnormalityId] =
          (abnormalityTotals[abnormalityId] ?? 0) + bonus;
    });

    return copyWith(
      hp: hp + hpBonus,
      ap: ap + apBonus,
      attack: attack + attackBonus,
      defense: defense + defenseBonus,
      speed: speed + speedBonus,
      evasionRate: evasionRate + evasionRateBonus,
      abnormalityResistances: [
        for (final entry in abnormalityTotals.entries)
          if (entry.value != 0)
            AbnormalityResistance(
              abnormalityId: entry.key,
              value: entry.value,
            ),
      ],
    );
  }
}
