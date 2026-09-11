import 'package:data_pack/data_pack.dart';
import 'package:denpamemo_logics/denpamemo_logics.dart' as rust;

/// Translates DataPack models to the shared Rust calculation boundary.
class DenpaMenRustCalculator {
  const DenpaMenRustCalculator();

  /// Recalculates resistances and the compatibility hash for [denpaMen].
  DenpaMen recalculateResistances(DenpaMen denpaMen, MasterData masterData) {
    final result = rust.calculateDenpaMenResistances(
      selection: rust.BodyColorSelection(
        bodyColors: denpaMen.bodyColors,
        isSpColor: denpaMen.isSpColor,
      ),
      headShape: rust.HeadShapeResistanceBonuses(
        abnormalityResistanceBonuses: [
          for (final entry
              in denpaMen.headShape.abnormalityResistanceBonuses.entries)
            rust.ResistanceBonus(id: entry.key, bonus: entry.value),
        ],
        attributeResistanceBonuses: [
          for (final bonus in denpaMen.headShape.attributeResistanceBonuses)
            rust.AttributeResistanceBonus(
              attributeId: bonus.attribute.id,
              bonus: bonus.bonus,
            ),
        ],
      ),
      masterData: _toRustMasterData(masterData),
    );

    final recalculated = denpaMen.copyWith(
      abnormalityResistances: [
        for (final resistance in result.abnormalityResistances)
          AbnormalityResistance(
            abnormalityId: resistance.abnormalityId,
            value: resistance.value,
          ),
      ],
      attributeResistance: [
        for (final resistance in result.attributeResistance)
          AttributeResistance(
            attribute: masterData.attributes.firstWhere(
              (attribute) => attribute.id == resistance.attributeId,
            ),
            value: resistance.value,
          ),
      ],
    );
    return recalculated.copyWith(hash: computeDenpaMenHash(recalculated));
  }

  /// Sums correction growth-stat bonuses through the shared Rust engine.
  DenpaMenStatBonus correctionStatBonus(DenpaMen denpaMen) {
    final result = rust.calculateCorrectionStatBonus(
      input: rust.ResistanceCorrectionInput(
        corrections: [
          for (final correction in denpaMen.corrections)
            rust.CorrectionBonuses(
              statBonus: rust.StatBonus(
                hp: correction.hpBonus,
                ap: correction.apBonus,
                attack: correction.attackBonus,
                defense: correction.defenseBonus,
                speed: correction.speedBonus,
                evasionRate: correction.evasionRateBonus,
              ),
              abnormalityResistanceBonuses: [
                for (final entry
                    in correction.abnormalityResistanceBonuses.entries)
                  rust.ResistanceBonus(id: entry.key, bonus: entry.value),
              ],
              attributeResistanceBonuses: const [],
            ),
        ],
        additionalCorrection: rust.CorrectionBonuses(
          statBonus: rust.StatBonus(
            hp: denpaMen.additionalCorrection.hpBonus,
            ap: denpaMen.additionalCorrection.apBonus,
            attack: denpaMen.additionalCorrection.attackBonus,
            defense: denpaMen.additionalCorrection.defenseBonus,
            speed: denpaMen.additionalCorrection.speedBonus,
            evasionRate: denpaMen.additionalCorrection.evasionRateBonus,
          ),
          abnormalityResistanceBonuses: const [],
          attributeResistanceBonuses: const [],
        ),
      ),
    );
    return (
      hp: result.hp,
      ap: result.ap,
      attack: result.attack,
      defense: result.defense,
      speed: result.speed,
      evasionRate: result.evasionRate,
    );
  }

  rust.ResistanceMasterData _toRustMasterData(MasterData masterData) =>
      rust.ResistanceMasterData(
        attributes: [
          for (final attribute in masterData.attributes)
            rust.ResistanceAttribute(
              id: attribute.id,
              index: attribute.index,
              isElemental: attribute.isElemental,
            ),
        ],
        bodyColorResistanceRules: [
          for (final rule in masterData.bodyColorResistanceRules)
            rust.BodyColorResistanceRule(
              colorId: rule.colorId,
              attributeResistanceBonuses: [
                for (final bonus in rule.attributeResistanceBonuses)
                  rust.AttributeResistanceBonus(
                    attributeId: bonus.attribute.id,
                    bonus: bonus.bonus,
                  ),
              ],
            ),
        ],
        bodyColorAbnormalityResistanceRules: [
          for (final rule in masterData.bodyColorAbnormalityResistanceRules)
            rust.BodyColorAbnormalityResistanceRule(
              colorId: rule.colorId,
              abnormalityResistanceBonuses: [
                for (final entry in rule.abnormalityResistanceBonuses.entries)
                  rust.ResistanceBonus(id: entry.key, bonus: entry.value),
              ],
            ),
        ],
      );
}
