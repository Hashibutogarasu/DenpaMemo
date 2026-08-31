/// The `masterData` query document, requesting every field the domain's
/// Freezed models need. `id` (a server-only cuid) is requested only where
/// needed to resolve relations server-side; every model the client builds
/// keys off `legacyId` instead, matching the semantic ids the JSON assets
/// used before the server migration.
const masterDataQuery = r'''
query MasterData {
  masterData {
    headShapes {
      legacyId
      abnormalityResistanceBonuses
      attributeResistanceBonuses {
        attribute {
          legacyId
          index
          category { name }
        }
        bonus
      }
      hpBonus
      apBonus
      attackBonus
      defenseBonus
      speedBonus
      evasionRateBonus
    }
    anntenas {
      legacyId
      category { name }
      targetCount
      targetMode { code }
      dealsDamage
      attackAttributes {
        legacyId
        index
        category { name }
      }
      isInheritable
      evolvesToId
      maxLevel
      variantGroupId
      hasLevel
    }
    attributes {
      legacyId
      index
      category { name }
      resistantTo { legacyId index category { name } }
      weakTo { legacyId index category { name } }
    }
    abnormalityTypes {
      legacyId
    }
    bodyColorResistanceRules {
      legacyId
      attributeResistanceBonuses {
        attribute {
          legacyId
          index
          category { name }
        }
        bonus
      }
    }
    bodyColorAbnormalityResistanceRules {
      legacyId
      abnormalityResistanceBonuses
    }
    physiques {
      legacyId
    }
    personalities {
      legacyId
    }
    patterns {
      legacyId
    }
    corrections {
      legacyId
      hpBonus
      apBonus
      attackBonus
      defenseBonus
      speedBonus
      evasionRateBonus
      abnormalityResistanceBonuses
    }
  }
}
''';
