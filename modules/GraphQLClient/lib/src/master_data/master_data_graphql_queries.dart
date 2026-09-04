/// The `masterData` query document, requesting every field the domain's
/// Freezed models need. `id` is the semantic id from the JSON master-data
/// assets, and every model the client builds keys off it directly.
const masterDataQuery = r'''
query MasterData {
  masterData {
    headShapes {
      id
      abnormalityResistanceBonuses
      attributeResistanceBonuses {
        attribute {
          id
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
      id
      category { name }
      targetCount
      targetMode { code }
      dealsDamage
      attackAttributes {
        id
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
      id
      index
      category { name }
      resistantTo { id index category { name } }
      weakTo { id index category { name } }
    }
    abnormalityTypes {
      id
    }
    bodyColorResistanceRules {
      id
      attributeResistanceBonuses {
        attribute {
          id
          index
          category { name }
        }
        bonus
      }
    }
    bodyColorAbnormalityResistanceRules {
      id
      abnormalityResistanceBonuses
    }
    physiques {
      id
    }
    personalities {
      id
    }
    patterns {
      id
    }
    corrections {
      id
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
