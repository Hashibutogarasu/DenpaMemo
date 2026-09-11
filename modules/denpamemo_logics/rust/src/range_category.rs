use std::collections::HashSet;

use flutter_rust_bridge::frb;
use serde::{Deserialize, Serialize};

/// One row of a value-range-to-category mapping table.
#[derive(Debug, Clone, PartialEq, Eq, Serialize, Deserialize)]
#[serde(rename_all = "camelCase")]
pub struct RangeCategory {
    pub id: String,
    pub range_start: i32,
    pub range_end: i32,
    pub column_index: i32,
    pub category_key: String,
    pub tag: Option<String>,
}

/// A category a `(value, column_index)` pair resolved to.
#[derive(Debug, Clone, PartialEq, Eq, Serialize, Deserialize)]
#[serde(rename_all = "camelCase")]
pub struct CategoryMatch {
    pub category_key: String,
    pub tag: Option<String>,
    pub range_start: i32,
    pub range_end: i32,
}

/// Resolves a `(value, column_index)` pair to every category whose range
/// contains `value` at the same `column_index`. More than one row can
/// match (e.g. a plus/minus pair), in which case every match is kept,
/// deduplicated and in first-seen order.
#[frb(sync)]
pub fn resolve_categories(categories: &[RangeCategory], value: i32, column_index: i32) -> Vec<CategoryMatch> {
    let mut seen = HashSet::new();
    let mut result = Vec::new();

    for category in categories {
        if value < category.range_start || value > category.range_end || category.column_index != column_index {
            continue;
        }
        let key = (
            category.category_key.clone(),
            category.tag.clone(),
            category.range_start,
            category.range_end,
        );
        if seen.insert(key) {
            result.push(CategoryMatch {
                category_key: category.category_key.clone(),
                tag: category.tag.clone(),
                range_start: category.range_start,
                range_end: category.range_end,
            });
        }
    }

    result
}

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn resolves_only_ranges_in_the_requested_column() {
        let categories = vec![
            RangeCategory {
                id: "wrong-column".to_owned(),
                range_start: 0,
                range_end: 10,
                column_index: 1,
                category_key: "other".to_owned(),
                tag: None,
            },
            RangeCategory {
                id: "match".to_owned(),
                range_start: 5,
                range_end: 10,
                column_index: 3,
                category_key: "fast".to_owned(),
                tag: None,
            },
        ];

        assert_eq!(
            resolve_categories(&categories, 7, 3),
            vec![CategoryMatch {
                category_key: "fast".to_owned(),
                tag: None,
                range_start: 5,
                range_end: 10,
            }]
        );
    }
}
