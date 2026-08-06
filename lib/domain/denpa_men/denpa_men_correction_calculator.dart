import 'abnormality_resistance.dart';
import 'denpa_men.dart';

/// The combined growth-stat bonus a [DenpaMen]'s [DenpaMen.corrections]
/// contribute, as produced by
/// [DenpaMenCorrectionCalculation.correctionsStatBonus].
typedef DenpaMenStatBonus = ({
  int hp,
  int ap,
  int attack,
  int defense,
  int speed,
  int evasionRate,
});

/// Applies a [DenpaMen]'s [DenpaMen.corrections] on top of its
/// already-calculated growth stats and abnormality resistances — the last
/// step in the pipeline, right before a [DenpaMen] is finalized.
extension DenpaMenCorrectionCalculation on DenpaMen {
  /// Sums [DenpaMen.corrections]' growth-stat bonuses, without applying
  /// them — used to show the pending bonus alongside an editable base stat.
  DenpaMenStatBonus correctionsStatBonus() {
    var hpBonus = 0;
    var apBonus = 0;
    var attackBonus = 0;
    var defenseBonus = 0;
    var speedBonus = 0;
    var evasionRateBonus = 0;

    for (final correction in corrections) {
      hpBonus += correction.hpBonus;
      apBonus += correction.apBonus;
      attackBonus += correction.attackBonus;
      defenseBonus += correction.defenseBonus;
      speedBonus += correction.speedBonus;
      evasionRateBonus += correction.evasionRateBonus;
    }

    return (
      hp: hpBonus,
      ap: apBonus,
      attack: attackBonus,
      defense: defenseBonus,
      speed: speedBonus,
      evasionRate: evasionRateBonus,
    );
  }

  DenpaMen applyCorrections() {
    if (corrections.isEmpty) return this;

    final statBonus = correctionsStatBonus();
    final abnormalityBonuses = <String, int>{};
    for (final correction in corrections) {
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
      hp: hp + statBonus.hp,
      ap: ap + statBonus.ap,
      attack: attack + statBonus.attack,
      defense: defense + statBonus.defense,
      speed: speed + statBonus.speed,
      evasionRate: evasionRate + statBonus.evasionRate,
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
