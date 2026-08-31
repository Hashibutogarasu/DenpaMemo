import 'denpa_men.dart';
import 'denpa_men_stat_bonus.dart';

/// Derives a [DenpaMen]'s head shape growth-stat bonus, mirroring how
/// [DenpaMen.headShape]'s abnormality/attribute resistance bonus is
/// already layered on top of body color in
/// `DenpaMenResistanceCalculation.calculateResistances`.
extension DenpaMenHeadShapeStatCalculation on DenpaMen {
  DenpaMenStatBonus headShapeStatBonus() => (
    hp: headShape.hpBonus,
    ap: headShape.apBonus,
    attack: headShape.attackBonus,
    defense: headShape.defenseBonus,
    speed: headShape.speedBonus,
    evasionRate: headShape.evasionRateBonus,
  );
}
