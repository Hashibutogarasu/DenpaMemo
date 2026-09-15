use serde::Serialize;
use wasm_bindgen::prelude::*;

use crate::category_grid::{build_category_grid, compact_categories, CategoryGridRequest};
use crate::range_category::{resolve_categories, RangeCategory};
use crate::resistance::{
    calculate_attribute_resistance, calculate_color_abnormality_resistance,
    calculate_correction_stat_bonus, calculate_denpa_men_resistances,
    find_color_combination, AttributeResistance,
    BodyColorSelection, HeadShapeResistanceBonuses, ResistanceCorrectionInput,
    ResistanceMasterData,
};
use crate::status_match::{find_matching_columns, StatusCriterion};

fn from_js<T: for<'de> serde::Deserialize<'de>>(value: JsValue) -> Result<T, JsValue> {
    serde_wasm_bindgen::from_value(value).map_err(|error| JsValue::from_str(&error.to_string()))
}

/// Serializes via a serializer that maps `None` to JS `null` rather than
/// `undefined`, so a JS-side `toEqual(null)` (rather than
/// `toBeUndefined()`) on an absent `tag`/`sign` field holds.
fn to_js<T: Serialize>(value: &T) -> Result<JsValue, JsValue> {
    let serializer = serde_wasm_bindgen::Serializer::new().serialize_missing_as_null(true);
    value.serialize(&serializer).map_err(|error| JsValue::from_str(&error.to_string()))
}

#[wasm_bindgen(js_name = findMatchingColumns)]
pub fn find_matching_columns_js(primary: JsValue, others: JsValue) -> Result<JsValue, JsValue> {
    let primary: StatusCriterion = from_js(primary)?;
    let others: Vec<StatusCriterion> = from_js(others)?;
    to_js(&find_matching_columns(&primary, &others))
}

#[wasm_bindgen(js_name = resolveCategories)]
pub fn resolve_categories_js(categories: JsValue, value: i32, column_index: i32) -> Result<JsValue, JsValue> {
    let categories: Vec<RangeCategory> = from_js(categories)?;
    to_js(&resolve_categories(&categories, value, column_index))
}

#[wasm_bindgen(js_name = buildCategoryGrid)]
pub fn build_category_grid_js(request: JsValue) -> Result<JsValue, JsValue> {
    let request: CategoryGridRequest = from_js(request)?;
    to_js(&build_category_grid(request))
}

#[wasm_bindgen(js_name = compactCategories)]
pub fn compact_categories_js(categories: JsValue) -> Result<JsValue, JsValue> {
    let categories: Vec<RangeCategory> = from_js(categories)?;
    to_js(&compact_categories(&categories))
}

#[wasm_bindgen(js_name = calculateAttributeResistance)]
pub fn calculate_attribute_resistance_js(
    selection: JsValue,
    master_data: JsValue,
) -> Result<JsValue, JsValue> {
    let selection: BodyColorSelection = from_js(selection)?;
    let master_data: ResistanceMasterData = from_js(master_data)?;
    let result = calculate_attribute_resistance(&selection, &master_data)
        .map_err(|error| JsValue::from_str(&error))?;
    to_js(&result)
}

#[wasm_bindgen(js_name = calculateColorAbnormalityResistance)]
pub fn calculate_color_abnormality_resistance_js(
    selection: JsValue,
    master_data: JsValue,
) -> Result<JsValue, JsValue> {
    let selection: BodyColorSelection = from_js(selection)?;
    let master_data: ResistanceMasterData = from_js(master_data)?;
    to_js(&calculate_color_abnormality_resistance(&selection, &master_data))
}

#[wasm_bindgen(js_name = calculateDenpaMenResistances)]
pub fn calculate_denpa_men_resistances_js(
    selection: JsValue,
    head_shape: JsValue,
    master_data: JsValue,
) -> Result<JsValue, JsValue> {
    let selection: BodyColorSelection = from_js(selection)?;
    let head_shape: HeadShapeResistanceBonuses = from_js(head_shape)?;
    let master_data: ResistanceMasterData = from_js(master_data)?;
    let result = calculate_denpa_men_resistances(&selection, &head_shape, &master_data)
        .map_err(|error| JsValue::from_str(&error))?;
    to_js(&result)
}

#[wasm_bindgen(js_name = calculateCorrectionStatBonus)]
pub fn calculate_correction_stat_bonus_js(input: JsValue) -> Result<JsValue, JsValue> {
    let input: ResistanceCorrectionInput = from_js(input)?;
    to_js(&calculate_correction_stat_bonus(&input))
}

#[wasm_bindgen(js_name = findColorCombination)]
pub fn find_color_combination_js(
    target: JsValue,
    master_data: JsValue,
) -> Result<JsValue, JsValue> {
    let target: Vec<AttributeResistance> = from_js(target)?;
    let master_data: ResistanceMasterData = from_js(master_data)?;
    let result = find_color_combination(&target, &master_data)
        .map_err(|error| JsValue::from_str(&error))?;
    to_js(&result)
}
