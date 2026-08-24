import { describe, expect, test } from 'vitest';
import { headShapeStatBonus } from '../../../src/domain/stats/head-shape-stat-calculator';
import {
  correctionsAbnormalityResistanceBonuses,
  correctionsStatBonus,
} from '../../../src/domain/stats/correction-calculator';

const protagonist = {
  hpBonus: 12,
  apBonus: 0,
  attackBonus: 0,
  defenseBonus: 0,
  speedBonus: 0,
  evasionRateBonus: 0,
  abnormalityResistanceBonuses: { suddenDeath: 2 },
};

const sun = {
  hpBonus: 0,
  apBonus: 0,
  attackBonus: 50,
  defenseBonus: 100,
  speedBonus: 0,
  evasionRateBonus: 0,
};

const wing = {
  hpBonus: 0,
  apBonus: 0,
  attackBonus: 0,
  defenseBonus: 0,
  speedBonus: 20,
  evasionRateBonus: 15,
};

describe('correctionsStatBonus / correctionsAbnormalityResistanceBonuses', () => {
  test('protagonist correction adds HP +12 and suddenDeath resistance +2', () => {
    expect(correctionsStatBonus([protagonist])).toEqual({
      hp: 12,
      ap: 0,
      attack: 0,
      defense: 0,
      speed: 0,
      evasionRate: 0,
    });
    expect(correctionsAbnormalityResistanceBonuses([protagonist])).toEqual({ suddenDeath: 2 });
  });

  test('sun head shape grants attack +50 and defense +100, protagonist stacks on top', () => {
    const headShapeBonus = headShapeStatBonus(sun);
    const correctionBonus = correctionsStatBonus([protagonist]);
    expect(headShapeBonus.attack + correctionBonus.attack).toBe(50);
    expect(headShapeBonus.defense + correctionBonus.defense).toBe(100);
    expect(headShapeBonus.hp + correctionBonus.hp).toBe(12);
  });

  test('wing head shape grants speed +20 and evasionRate +15 with no corrections', () => {
    const headShapeBonus = headShapeStatBonus(wing);
    const correctionBonus = correctionsStatBonus([]);
    expect(headShapeBonus.speed + correctionBonus.speed).toBe(20);
    expect(headShapeBonus.evasionRate + correctionBonus.evasionRate).toBe(15);
  });
});
