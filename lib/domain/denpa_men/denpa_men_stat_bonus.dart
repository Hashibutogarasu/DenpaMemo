/// A per-stat bonus some part of a [DenpaMen] contributes (e.g. its head
/// shape or its corrections), before being layered onto a base growth
/// stat.
typedef DenpaMenStatBonus = ({
  int hp,
  int ap,
  int attack,
  int defense,
  int speed,
  int evasionRate,
});

/// Combines two [DenpaMenStatBonus] values field by field.
extension DenpaMenStatBonusMath on DenpaMenStatBonus {
  DenpaMenStatBonus operator +(DenpaMenStatBonus other) => (
    hp: hp + other.hp,
    ap: ap + other.ap,
    attack: attack + other.attack,
    defense: defense + other.defense,
    speed: speed + other.speed,
    evasionRate: evasionRate + other.evasionRate,
  );
}
