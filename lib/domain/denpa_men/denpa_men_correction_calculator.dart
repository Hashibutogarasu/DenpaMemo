import 'abnormality_resistance.dart';
import 'denpa_men.dart';
import 'denpa_men_head_shape_stat_calculator.dart';
import 'denpa_men_stat_bonus.dart';

/// Applies a [DenpaMen]'s head shape and [DenpaMen.corrections] growth-stat
/// bonuses on top of its already-calculated base stats and abnormality
/// resistances — the last step in the pipeline, right before a [DenpaMen]
/// is finalized.
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

  /// [includeCorrectionStatBonus] controls whether [correctionsStatBonus]
  /// (the growth-stat bonus from [DenpaMen.corrections], as opposed to head
  /// shape's own bonus or the corrections' abnormality resistance bonuses,
  /// which always apply) is added on top of the base growth stats. Set to
  /// false when the edited values already account for it, so the result
  /// mirrors the edited stats exactly instead of adding on top of them.
  DenpaMen applyCorrections({bool includeCorrectionStatBonus = true}) {
    final statBonus =
        headShapeStatBonus() +
        (includeCorrectionStatBonus
            ? correctionsStatBonus()
            : (hp: 0, ap: 0, attack: 0, defense: 0, speed: 0, evasionRate: 0));
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
            AbnormalityResistance(abnormalityId: entry.key, value: entry.value),
      ],
    );
  }
}
