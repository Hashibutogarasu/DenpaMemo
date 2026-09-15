use flutter_rust_bridge::frb;
use indexmap::IndexMap;
use serde::{Deserialize, Serialize};

#[derive(Debug, Clone, PartialEq, Eq, Serialize, Deserialize)]
#[serde(rename_all = "camelCase")]
pub struct ResistanceAttribute {
    pub id: String,
    pub index: i32,
    pub is_elemental: bool,
}

#[derive(Debug, Clone, PartialEq, Eq, Serialize, Deserialize)]
#[serde(rename_all = "camelCase")]
pub struct ResistanceBonus {
    pub id: String,
    pub bonus: i32,
}

#[derive(Debug, Clone, PartialEq, Eq, Serialize, Deserialize)]
#[serde(rename_all = "camelCase")]
pub struct AttributeResistanceBonus {
    pub attribute_id: String,
    pub bonus: i32,
}

#[derive(Debug, Clone, PartialEq, Eq, Serialize, Deserialize)]
#[serde(rename_all = "camelCase")]
pub struct BodyColorResistanceRule {
    pub color_id: String,
    pub attribute_resistance_bonuses: Vec<AttributeResistanceBonus>,
}

#[derive(Debug, Clone, PartialEq, Eq, Serialize, Deserialize)]
#[serde(rename_all = "camelCase")]
pub struct BodyColorAbnormalityResistanceRule {
    pub color_id: String,
    pub abnormality_resistance_bonuses: Vec<ResistanceBonus>,
}

#[derive(Debug, Clone, PartialEq, Eq, Serialize, Deserialize)]
#[serde(rename_all = "camelCase")]
pub struct ResistanceMasterData {
    pub attributes: Vec<ResistanceAttribute>,
    pub body_color_resistance_rules: Vec<BodyColorResistanceRule>,
    pub body_color_abnormality_resistance_rules: Vec<BodyColorAbnormalityResistanceRule>,
}

#[derive(Debug, Clone, PartialEq, Eq, Serialize, Deserialize)]
#[serde(rename_all = "camelCase")]
pub struct BodyColorSelection {
    pub body_colors: Vec<String>,
    pub is_sp_color: bool,
}

#[derive(Debug, Clone, PartialEq, Eq, Serialize, Deserialize)]
#[serde(rename_all = "camelCase")]
pub struct AttributeResistance {
    pub attribute_id: String,
    pub value: i32,
}

#[derive(Debug, Clone, PartialEq, Eq, Serialize, Deserialize)]
#[serde(rename_all = "camelCase")]
pub struct AbnormalityResistance {
    pub abnormality_id: String,
    pub value: i32,
}

#[derive(Debug, Clone, PartialEq, Eq, Serialize, Deserialize)]
#[serde(rename_all = "camelCase")]
pub struct DenpaMenResistances {
    pub abnormality_resistances: Vec<AbnormalityResistance>,
    pub attribute_resistance: Vec<AttributeResistance>,
}

#[derive(Debug, Clone, PartialEq, Eq, Serialize, Deserialize)]
#[serde(rename_all = "camelCase")]
pub struct HeadShapeResistanceBonuses {
    pub abnormality_resistance_bonuses: Vec<ResistanceBonus>,
    pub attribute_resistance_bonuses: Vec<AttributeResistanceBonus>,
}

#[derive(Debug, Clone, PartialEq, Eq, Serialize, Deserialize)]
#[serde(rename_all = "camelCase")]
pub struct StatBonus {
    pub hp: i32,
    pub ap: i32,
    pub attack: i32,
    pub defense: i32,
    pub speed: i32,
    pub evasion_rate: i32,
}

#[derive(Debug, Clone, PartialEq, Eq, Serialize, Deserialize)]
#[serde(rename_all = "camelCase")]
pub struct CorrectionBonuses {
    pub stat_bonus: StatBonus,
    pub abnormality_resistance_bonuses: Vec<ResistanceBonus>,
    pub attribute_resistance_bonuses: Vec<AttributeResistanceBonus>,
}

#[derive(Debug, Clone, PartialEq, Eq, Serialize, Deserialize)]
#[serde(rename_all = "camelCase")]
pub struct ResistanceCorrectionInput {
    pub corrections: Vec<CorrectionBonuses>,
    pub additional_correction: CorrectionBonuses,
}

fn attribute_resistance_totals(
    selection: &BodyColorSelection,
    master_data: &ResistanceMasterData,
) -> Result<IndexMap<String, i32>, String> {
    let rules_by_color_id: IndexMap<&str, &BodyColorResistanceRule> = master_data
        .body_color_resistance_rules
        .iter()
        .map(|rule| (rule.color_id.as_str(), rule))
        .collect();
    let rules: Vec<&BodyColorResistanceRule> = selection
        .body_colors
        .iter()
        .map(|color_id| {
            rules_by_color_id
                .get(color_id.as_str())
                .copied()
                .ok_or_else(|| format!("No body color resistance rule for colorId \"{color_id}\""))
        })
        .collect::<Result<_, _>>()?;
    let elemental_ids: Vec<&str> = master_data
        .attributes
        .iter()
        .filter(|attribute| attribute.is_elemental)
        .map(|attribute| attribute.id.as_str())
        .collect();
    let is_same_color_pair = selection.body_colors.len() == 2
        && selection.body_colors.first() == selection.body_colors.get(1);
    let is_distinct_color_pair = selection.body_colors.len() == 2 && !is_same_color_pair;
    let base_rule = if is_distinct_color_pair {
        None
    } else {
        rules.first().copied()
    };

    let mut totals = IndexMap::new();
    if is_distinct_color_pair {
        for rule in &rules {
            for bonus in &rule.attribute_resistance_bonuses {
                *totals.entry(bonus.attribute_id.clone()).or_insert(0) += bonus.bonus;
            }
        }
    } else if let Some(rule) = base_rule {
        for bonus in &rule.attribute_resistance_bonuses {
            totals.insert(bonus.attribute_id.clone(), bonus.bonus);
        }
    }

    if let Some(rule) = base_rule {
        apply_solo_or_pair_effects(
            &mut totals,
            &rule.attribute_resistance_bonuses,
            &elemental_ids,
            selection.is_sp_color,
            is_same_color_pair,
        );
    }

    if is_distinct_color_pair {
        for value in totals.values_mut() {
            *value /= 2;
        }
    }

    Ok(totals)
}

fn apply_solo_or_pair_effects(
    totals: &mut IndexMap<String, i32>,
    own_bonuses: &[AttributeResistanceBonus],
    elemental_ids: &[&str],
    is_sp_color: bool,
    is_same_color_pair: bool,
) {
    if own_bonuses.is_empty() {
        if is_sp_color {
            for attribute_id in elemental_ids {
                *totals.entry((*attribute_id).to_owned()).or_insert(0) += 1;
            }
        }
        return;
    }

    let has_own_strength = own_bonuses.iter().any(|bonus| bonus.bonus > 0);
    let is_full_negative_coverage = !has_own_strength && own_bonuses.len() == elemental_ids.len();

    if is_sp_color {
        if has_own_strength {
            for value in totals.values_mut() {
                if *value < 0 {
                    *value = 0;
                }
            }
        } else if is_full_negative_coverage {
            for attribute_id in elemental_ids {
                totals.insert((*attribute_id).to_owned(), -1);
            }
        }
    } else if is_same_color_pair {
        if has_own_strength {
            for value in totals.values_mut() {
                if *value > 0 {
                    *value += 1;
                } else if *value < 0 {
                    *value -= 1;
                }
            }
        } else if is_full_negative_coverage {
            for value in totals.values_mut() {
                *value += 1;
            }
        }
    }
}

/// Calculates elemental resistance for a body-color selection.
#[frb(sync)]
pub fn calculate_attribute_resistance(
    selection: &BodyColorSelection,
    master_data: &ResistanceMasterData,
) -> Result<Vec<AttributeResistance>, String> {
    let totals = attribute_resistance_totals(selection, master_data)?;
    let mut result: Vec<_> = totals
        .into_iter()
        .filter(|(_, value)| *value != 0)
        .map(|(attribute_id, value)| AttributeResistance { attribute_id, value })
        .collect();
    result.sort_by_key(|resistance| {
        master_data
            .attributes
            .iter()
            .find(|attribute| attribute.id == resistance.attribute_id)
            .map_or(0, |attribute| attribute.index)
    });
    Ok(result)
}

/// Calculates abnormality resistance for a body-color selection.
#[frb(sync)]
pub fn calculate_color_abnormality_resistance(
    selection: &BodyColorSelection,
    master_data: &ResistanceMasterData,
) -> Vec<AbnormalityResistance> {
    let rules_by_color_id: IndexMap<&str, &BodyColorAbnormalityResistanceRule> = master_data
        .body_color_abnormality_resistance_rules
        .iter()
        .map(|rule| (rule.color_id.as_str(), rule))
        .collect();
    let mut totals = IndexMap::new();
    for color_id in &selection.body_colors {
        if let Some(rule) = rules_by_color_id.get(color_id.as_str()) {
            for bonus in &rule.abnormality_resistance_bonuses {
                *totals.entry(bonus.id.clone()).or_insert(0) += bonus.bonus;
            }
        }
    }
    totals
        .into_iter()
        .map(|(abnormality_id, value)| AbnormalityResistance { abnormality_id, value })
        .collect()
}

/// Combines body-color and head-shape resistance bonuses.
#[frb(sync)]
pub fn calculate_denpa_men_resistances(
    selection: &BodyColorSelection,
    head_shape: &HeadShapeResistanceBonuses,
    master_data: &ResistanceMasterData,
) -> Result<DenpaMenResistances, String> {
    let mut abnormality_totals: IndexMap<String, i32> = calculate_color_abnormality_resistance(
        selection,
        master_data,
    )
    .into_iter()
    .map(|resistance| (resistance.abnormality_id, resistance.value))
    .collect();
    let mut attribute_totals: IndexMap<String, i32> = calculate_attribute_resistance(
        selection,
        master_data,
    )?
    .into_iter()
    .map(|resistance| (resistance.attribute_id, resistance.value))
    .collect();

    for bonus in &head_shape.abnormality_resistance_bonuses {
        *abnormality_totals.entry(bonus.id.clone()).or_insert(0) += bonus.bonus;
    }
    for bonus in &head_shape.attribute_resistance_bonuses {
        *attribute_totals.entry(bonus.attribute_id.clone()).or_insert(0) += bonus.bonus;
    }

    let abnormality_resistances = abnormality_totals
        .into_iter()
        .filter(|(_, value)| *value != 0)
        .map(|(abnormality_id, value)| AbnormalityResistance { abnormality_id, value })
        .collect();
    let mut attribute_resistance = attribute_totals
        .into_iter()
        .filter(|(_, value)| *value != 0)
        .map(|(attribute_id, value)| AttributeResistance { attribute_id, value })
        .collect::<Vec<_>>();
    attribute_resistance.sort_by_key(|resistance| {
        master_data
            .attributes
            .iter()
            .find(|attribute| attribute.id == resistance.attribute_id)
            .map_or(0, |attribute| attribute.index)
    });

    Ok(DenpaMenResistances {
        abnormality_resistances,
        attribute_resistance,
    })
}

/// Sums growth-stat bonuses from corrections and an additional correction.
#[frb(sync)]
pub fn calculate_correction_stat_bonus(input: &ResistanceCorrectionInput) -> StatBonus {
    let mut result = StatBonus {
        hp: 0,
        ap: 0,
        attack: 0,
        defense: 0,
        speed: 0,
        evasion_rate: 0,
    };
    for correction in input
        .corrections
        .iter()
        .chain(std::iter::once(&input.additional_correction))
    {
        result.hp += correction.stat_bonus.hp;
        result.ap += correction.stat_bonus.ap;
        result.attack += correction.stat_bonus.attack;
        result.defense += correction.stat_bonus.defense;
        result.speed += correction.stat_bonus.speed;
        result.evasion_rate += correction.stat_bonus.evasion_rate;
    }
    result
}

/// Finds the first body-color selection that produces the requested resistance.
#[frb(sync)]
pub fn find_color_combination(
    target: &[AttributeResistance],
    master_data: &ResistanceMasterData,
) -> Result<Option<BodyColorSelection>, String> {
    let target_map: IndexMap<&str, i32> = target
        .iter()
        .map(|resistance| (resistance.attribute_id.as_str(), resistance.value))
        .collect();
    let color_ids: Vec<String> = master_data
        .body_color_resistance_rules
        .iter()
        .map(|rule| rule.color_id.clone())
        .collect();

    let mut candidates = Vec::new();
    for color_id in &color_ids {
        candidates.push(BodyColorSelection {
            body_colors: vec![color_id.clone()],
            is_sp_color: false,
        });
    }
    for color_id in &color_ids {
        candidates.push(BodyColorSelection {
            body_colors: vec![color_id.clone()],
            is_sp_color: true,
        });
    }
    for color_id in &color_ids {
        candidates.push(BodyColorSelection {
            body_colors: vec![color_id.clone(), color_id.clone()],
            is_sp_color: false,
        });
    }
    for (index, first) in color_ids.iter().enumerate() {
        for second in color_ids.iter().skip(index + 1) {
            candidates.push(BodyColorSelection {
                body_colors: vec![first.clone(), second.clone()],
                is_sp_color: false,
            });
        }
    }

    for candidate in candidates {
        let result = calculate_attribute_resistance(&candidate, master_data)?;
        let result_map: IndexMap<&str, i32> = result
            .iter()
            .map(|resistance| (resistance.attribute_id.as_str(), resistance.value))
            .collect();
        if result_map == target_map {
            return Ok(Some(candidate));
        }
    }
    Ok(None)
}

#[cfg(test)]
mod tests {
    use super::*;

    fn master_data() -> ResistanceMasterData {
        ResistanceMasterData {
            attributes: vec![
                ResistanceAttribute {
                    id: "fire".to_owned(),
                    index: 0,
                    is_elemental: true,
                },
                ResistanceAttribute {
                    id: "water".to_owned(),
                    index: 1,
                    is_elemental: true,
                },
                ResistanceAttribute {
                    id: "special".to_owned(),
                    index: 2,
                    is_elemental: false,
                },
            ],
            body_color_resistance_rules: vec![
                BodyColorResistanceRule {
                    color_id: "red".to_owned(),
                    attribute_resistance_bonuses: vec![AttributeResistanceBonus {
                        attribute_id: "fire".to_owned(),
                        bonus: 2,
                    }],
                },
                BodyColorResistanceRule {
                    color_id: "blue".to_owned(),
                    attribute_resistance_bonuses: vec![AttributeResistanceBonus {
                        attribute_id: "water".to_owned(),
                        bonus: 2,
                    }],
                },
                BodyColorResistanceRule {
                    color_id: "pink".to_owned(),
                    attribute_resistance_bonuses: vec![
                        AttributeResistanceBonus {
                            attribute_id: "fire".to_owned(),
                            bonus: -3,
                        },
                        AttributeResistanceBonus {
                            attribute_id: "water".to_owned(),
                            bonus: -3,
                        },
                    ],
                },
            ],
            body_color_abnormality_resistance_rules: vec![
                BodyColorAbnormalityResistanceRule {
                    color_id: "red".to_owned(),
                    abnormality_resistance_bonuses: vec![ResistanceBonus {
                        id: "burn".to_owned(),
                        bonus: 1,
                    }],
                },
            ],
        }
    }

    #[test]
    fn distinct_pairs_truncate_negative_values_toward_zero() {
        let data = master_data();
        let result = calculate_attribute_resistance(
            &BodyColorSelection {
                body_colors: vec!["pink".to_owned(), "red".to_owned()],
                is_sp_color: false,
            },
            &data,
        )
        .unwrap();

        assert_eq!(
            result,
            vec![AttributeResistance {
                attribute_id: "water".to_owned(),
                value: -1,
            }]
        );
    }

    #[test]
    fn same_color_pairs_intensify_positive_bonuses() {
        let data = master_data();
        let result = calculate_attribute_resistance(
            &BodyColorSelection {
                body_colors: vec!["red".to_owned(), "red".to_owned()],
                is_sp_color: false,
            },
            &data,
        )
        .unwrap();

        assert_eq!(
            result,
            vec![AttributeResistance {
                attribute_id: "fire".to_owned(),
                value: 3,
            }]
        );
    }

    #[test]
    fn abnormality_bonuses_are_summed_without_halving() {
        let data = master_data();
        let result = calculate_color_abnormality_resistance(
            &BodyColorSelection {
                body_colors: vec!["red".to_owned(), "red".to_owned()],
                is_sp_color: false,
            },
            &data,
        );

        assert_eq!(
            result,
            vec![AbnormalityResistance {
                abnormality_id: "burn".to_owned(),
                value: 2,
            }]
        );
    }

    #[test]
    fn reverse_lookup_returns_the_first_matching_candidate() {
        let data = master_data();
        let result = find_color_combination(
            &[AttributeResistance {
                attribute_id: "fire".to_owned(),
                value: 2,
            }],
            &data,
        )
        .unwrap();

        assert_eq!(
            result,
            Some(BodyColorSelection {
                body_colors: vec!["red".to_owned()],
                is_sp_color: false,
            })
        );
    }

    #[test]
    fn correction_stat_bonuses_include_the_additional_correction() {
        let input = ResistanceCorrectionInput {
            corrections: vec![CorrectionBonuses {
                stat_bonus: StatBonus {
                    hp: 1,
                    ap: 2,
                    attack: 3,
                    defense: 4,
                    speed: 5,
                    evasion_rate: 6,
                },
                abnormality_resistance_bonuses: vec![],
                attribute_resistance_bonuses: vec![],
            }],
            additional_correction: CorrectionBonuses {
                stat_bonus: StatBonus {
                    hp: 10,
                    ap: 20,
                    attack: 30,
                    defense: 40,
                    speed: 50,
                    evasion_rate: 60,
                },
                abnormality_resistance_bonuses: vec![],
                attribute_resistance_bonuses: vec![],
            },
        };

        assert_eq!(
            calculate_correction_stat_bonus(&input),
            StatBonus {
                hp: 11,
                ap: 22,
                attack: 33,
                defense: 44,
                speed: 55,
                evasion_rate: 66,
            }
        );
    }
}
