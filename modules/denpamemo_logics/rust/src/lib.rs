mod frb_generated; /* AUTO INJECTED BY flutter_rust_bridge. This line may not be accurate, and you can change it according to your needs. */
pub mod category_grid;
pub mod range_category;
pub mod resistance;
pub mod status_match;
pub mod table_row;

#[cfg(feature = "wasm")]
pub mod wasm;

pub use category_grid::{build_category_grid, compact_categories, CategoryCell, CategoryGrid, CategoryGridRequest, ValueCell};
pub use range_category::{resolve_categories, CategoryMatch, RangeCategory};
pub use resistance::{
    calculate_attribute_resistance, calculate_color_abnormality_resistance,
    calculate_correction_stat_bonus, calculate_denpa_men_resistances,
    find_color_combination, AbnormalityResistance, AttributeResistance,
    AttributeResistanceBonus, BodyColorAbnormalityResistanceRule,
    BodyColorResistanceRule, BodyColorSelection, CorrectionBonuses,
    DenpaMenResistances, HeadShapeResistanceBonuses, ResistanceAttribute,
    ResistanceBonus, ResistanceCorrectionInput, ResistanceMasterData, StatBonus,
};
pub use status_match::{find_matching_columns, StatusCriterion, StatusMatch};
pub use table_row::{collect_columns, ColumnEntry, TableRow};
