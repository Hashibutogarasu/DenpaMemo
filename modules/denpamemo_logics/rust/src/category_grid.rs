use std::collections::HashMap;

use flutter_rust_bridge::frb;
use serde::{Deserialize, Serialize};

use crate::range_category::RangeCategory;
use crate::table_row::{collect_columns, TableRow};

/// One legend cell: a category range paired with which real values (from
/// `primary_rows`) actually fall in it.
#[derive(Debug, Clone, PartialEq, Eq, Serialize, Deserialize)]
#[serde(rename_all = "camelCase")]
pub struct CategoryCell {
    pub category_id: String,
    pub range_start: i32,
    pub range_end: i32,
    pub column_index: i32,
    pub category_key: String,
    pub tag: Option<String>,
    pub live_values: Vec<i32>,
    pub is_match: bool,
}

/// One cell of the companion table, flattened per column.
#[derive(Debug, Clone, PartialEq, Eq, Serialize, Deserialize)]
#[serde(rename_all = "camelCase")]
pub struct ValueCell {
    pub column_index: i32,
    pub line_offset: i32,
    pub value: i32,
    pub is_match: bool,
}

#[derive(Debug, Clone, PartialEq, Eq, Serialize, Deserialize)]
#[serde(rename_all = "camelCase")]
pub struct CategoryGrid {
    pub category_cells: Vec<CategoryCell>,
    pub value_cells: Vec<ValueCell>,
}

/// `primary_rows` are matched against each category's range; `companion_rows`
/// are shown alongside for context only (e.g. a second status table).
#[derive(Debug, Clone, PartialEq, Eq, Serialize, Deserialize)]
#[serde(rename_all = "camelCase")]
pub struct CategoryGridRequest {
    pub categories: Vec<RangeCategory>,
    pub primary_rows: Vec<TableRow>,
    pub companion_rows: Vec<TableRow>,
    pub match_column_index: i32,
    pub match_line_offset: i32,
    pub match_value: i32,
}

/// Merges adjacent same-column, same-category, same-tag rows into one
/// wider range, without touching the underlying data.
#[frb(sync)]
pub fn compact_categories(categories: &[RangeCategory]) -> Vec<RangeCategory> {
    let mut by_column: HashMap<i32, Vec<RangeCategory>> = HashMap::new();
    for category in categories {
        by_column.entry(category.column_index).or_default().push(category.clone());
    }

    fn can_extend(previous: &RangeCategory, next: &RangeCategory) -> bool {
        previous.category_key == next.category_key
            && previous.tag == next.tag
            && previous.range_end + 1 == next.range_start
    }

    let mut columns: Vec<i32> = by_column.keys().copied().collect();
    columns.sort();

    let mut compacted = Vec::new();
    for column in columns {
        let mut ordered = by_column.remove(&column).unwrap();
        ordered.sort_by_key(|category| category.range_start);
        for category in ordered {
            match compacted.last_mut() {
                Some(last) if can_extend(last, &category) => {
                    let last: &mut RangeCategory = last;
                    last.range_end = category.range_end;
                }
                _ => compacted.push(category),
            }
        }
    }

    compacted
}

/// Builds the "matching location" grid: every category paired with the
/// real values that fall in its range, plus the companion table's
/// values, each flagged with whether it is the cell that was matched.
#[frb(sync)]
pub fn build_category_grid(request: CategoryGridRequest) -> CategoryGrid {
    let categories = compact_categories(&request.categories);
    let primary_columns = collect_columns(&request.primary_rows);
    let companion_columns = collect_columns(&request.companion_rows);

    let category_cells = categories
        .into_iter()
        .map(|category| {
            let column = primary_columns
                .get(category.column_index as usize)
                .cloned()
                .unwrap_or_default();
            let mut live_values: Vec<i32> = Vec::new();
            for entry in &column {
                if entry.value >= category.range_start
                    && entry.value <= category.range_end
                    && !live_values.contains(&entry.value)
                {
                    live_values.push(entry.value);
                }
            }
            let is_match = category.column_index == request.match_column_index
                && request.match_value >= category.range_start
                && request.match_value <= category.range_end;
            CategoryCell {
                category_id: category.id,
                range_start: category.range_start,
                range_end: category.range_end,
                column_index: category.column_index,
                category_key: category.category_key,
                tag: category.tag,
                live_values,
                is_match,
            }
        })
        .collect();

    let mut value_cells = Vec::new();
    for (column_index, entries) in companion_columns.into_iter().enumerate() {
        for entry in entries {
            value_cells.push(ValueCell {
                column_index: column_index as i32,
                line_offset: entry.line_offset,
                value: entry.value,
                is_match: column_index as i32 == request.match_column_index
                    && entry.line_offset == request.match_line_offset,
            });
        }
    }

    CategoryGrid {
        category_cells,
        value_cells,
    }
}
