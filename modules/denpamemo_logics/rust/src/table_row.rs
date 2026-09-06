use flutter_rust_bridge::frb;
use serde::{Deserialize, Serialize};

/// One row of a generic grouped table. `group` is an opaque grouping key
/// (this crate never inspects its meaning); `values` cells are `None`
/// for blank.
#[derive(Debug, Clone, PartialEq, Eq, Serialize, Deserialize)]
#[serde(rename_all = "camelCase")]
pub struct TableRow {
    pub group: Vec<String>,
    pub line_offset: i32,
    pub values: Vec<Option<i32>>,
}

/// One column's non-null value, plus which row it came from.
#[derive(Debug, Clone, PartialEq, Eq, Serialize, Deserialize)]
#[serde(rename_all = "camelCase")]
pub struct ColumnEntry {
    pub value: i32,
    pub line_offset: i32,
}

/// Collects every row into one per-column list of non-null entries,
/// keeping every value rather than overwriting on overlap (rows are
/// visited in `line_offset` order for deterministic column ordering).
#[frb(sync)]
pub fn collect_columns(rows: &[TableRow]) -> Vec<Vec<ColumnEntry>> {
    let column_count = rows.iter().map(|row| row.values.len()).max().unwrap_or(0);
    let mut columns: Vec<Vec<ColumnEntry>> = vec![Vec::new(); column_count];

    let mut ordered: Vec<&TableRow> = rows.iter().collect();
    ordered.sort_by_key(|row| row.line_offset);

    for row in ordered {
        for (index, value) in row.values.iter().enumerate() {
            if let Some(value) = value {
                columns[index].push(ColumnEntry {
                    value: *value,
                    line_offset: row.line_offset,
                });
            }
        }
    }

    columns
}
