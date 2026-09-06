use flutter_rust_bridge::frb;
use indexmap::IndexMap;
use serde::{Deserialize, Serialize};

use crate::table_row::{collect_columns, TableRow};

/// One status condition: search `rows` for `target_value`.
#[derive(Debug, Clone, PartialEq, Eq, Serialize, Deserialize)]
#[serde(rename_all = "camelCase")]
pub struct StatusCriterion {
    pub rows: Vec<TableRow>,
    pub target_value: i32,
}

/// A column that satisfied every given criterion at once.
#[derive(Debug, Clone, PartialEq, Eq, Serialize, Deserialize)]
#[serde(rename_all = "camelCase")]
pub struct StatusMatch {
    pub group: Vec<String>,
    pub line_offset: i32,
    pub column_index: i32,
}

fn group_by(rows: &[TableRow]) -> IndexMap<Vec<String>, Vec<&TableRow>> {
    let mut groups: IndexMap<Vec<String>, Vec<&TableRow>> = IndexMap::new();
    for row in rows {
        groups.entry(row.group.clone()).or_default().push(row);
    }
    groups
}

/// For each group shared by `primary` and every criterion in `others`,
/// finds every column where `primary` holds `primary.target_value` and
/// each of `others` holds its own `target_value` at that same column.
/// The reported `line_offset` is whichever `primary` row actually held
/// the matching value.
#[frb(sync)]
pub fn find_matching_columns(primary: &StatusCriterion, others: &[StatusCriterion]) -> Vec<StatusMatch> {
    let primary_groups = group_by(&primary.rows);
    let other_groups: Vec<IndexMap<Vec<String>, Vec<&TableRow>>> =
        others.iter().map(|criterion| group_by(&criterion.rows)).collect();

    let mut matches = Vec::new();

    for (group, rows) in &primary_groups {
        let mut other_columns_per_criterion = Vec::with_capacity(others.len());
        let mut missing = false;
        for other_groups_for_criterion in &other_groups {
            match other_groups_for_criterion.get(group) {
                Some(rows) => other_columns_per_criterion.push(collect_columns(&owned(rows))),
                None => {
                    missing = true;
                    break;
                }
            }
        }
        if missing {
            continue;
        }

        let primary_columns = collect_columns(&owned(rows));

        for (column_index, entries) in primary_columns.iter().enumerate() {
            let all_others_match = others.iter().enumerate().all(|(criterion_index, criterion)| {
                other_columns_per_criterion[criterion_index]
                    .get(column_index)
                    .map(|column| column.iter().any(|entry| entry.value == criterion.target_value))
                    .unwrap_or(false)
            });
            if !all_others_match {
                continue;
            }

            if let Some(matching_entry) = entries.iter().find(|entry| entry.value == primary.target_value) {
                matches.push(StatusMatch {
                    group: group.clone(),
                    line_offset: matching_entry.line_offset,
                    column_index: column_index as i32,
                });
            }
        }
    }

    matches
}

fn owned(rows: &[&TableRow]) -> Vec<TableRow> {
    rows.iter().map(|row| (*row).clone()).collect()
}
