import 'package:flutter/material.dart';

import 'package:api_client/api_client.dart';
import 'package:collection/collection.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:table_editor/table_editor.dart';

import 'package:denpa_memo/widgets.dart';
import '../data/server/physique_legend_grid_args.dart';
import '../data/server/physique_table_args.dart';
import '../i18n/gen/strings.g.dart';
import '../providers/physiques_providers.dart';
import '../widgets/icon/evasion_rate_sign_icon.dart';
import '../widgets/physique_table/physique_table_body.dart';

/// The evasion-rate legend's fixed column count — every physique table in
/// this app has 10 physique-class column slots (see `columnIndex` on
/// `LegendCell`), regardless of how many of them a given evasion-rate
/// value actually populates. The HP grid below gets its own column count
/// from `tableTypesProvider` via [PhysiqueTableBody] instead of this
/// constant.
const int _columnCount = 10;

/// Shows why a physique-identification search matched a given candidate:
/// the evasion-rate category legend (merged with the real evasion-rate
/// values for [args]'s level/antenna) stacked above the HP table for the
/// same level/antenna, with the one matched cell in each highlighted and
/// every other cell dimmed. The HP grid is [PhysiqueTableBody] — the same
/// widget, backed by the same `physiqueTableEditProvider` data, that
/// [PhysiqueTableViewPage] uses to show an HP table — rather than a
/// bespoke rendering derived from `/tables/legend-grid`, so the two pages
/// can never disagree about what an HP table contains.
class PhysiqueLegendGridPage extends ConsumerWidget {
  const PhysiqueLegendGridPage({required this.args, super.key});

  final PhysiqueLegendGridArgs args;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final t = context.t;
    final request = LegendGridRequest(
      level: args.level,
      anntenaCategory: args.anntenaCategory,
      matchColumnIndex: args.matchColumnIndex,
      matchLineOffset: args.matchLineOffset,
      matchEvasionRate: args.matchEvasionRate,
    );
    final gridAsync = ref.watch(legendGridProvider(request));

    return AppScaffold(
      title: OutlinedTitleText(
        text: t.physiqueIdentification.legendGridPageTitle,
      ),
      body: gridAsync.when(
        loading: () => const ProgressBar(),
        error: (_, _) =>
            Center(child: Text(t.physiqueIdentification.legendGridLoadError)),
        data: (grid) => Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                t.physiqueIdentification.legendGridSectionTitle,
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(height: 8),
              Expanded(
                child: TableEditor<_LegendGridRow>(
                  columns: _buildLegendColumns(
                    rangeColumnLabel:
                        t.physiqueIdentification.legendGridSectionTitle,
                  ),
                  data: _buildLegendRows(grid.legendCells),
                  rowId: (row) => row.id,
                ),
              ),
              const SizedBox(height: 24),
              Text(
                t.physiqueIdentification.hpGridSectionTitle,
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(height: 8),
              Expanded(
                child: PhysiqueTableBody(
                  args: PhysiqueTableArgs(
                    type: 'hp',
                    level: args.level,
                    anntenaCategory: args.anntenaCategory,
                  ),
                  isHighlighted: (lineOffset, columnIndex) =>
                      lineOffset == args.matchLineOffset &&
                      columnIndex == args.matchColumnIndex,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// One legend row: all `LegendCell`s sharing the same evasion-rate range,
/// laid out across the table's fixed [_columnCount] column slots — `null`
/// where that range has no legend entry at a given column.
class _LegendGridRow {
  const _LegendGridRow({
    required this.id,
    required this.rangeLabel,
    required this.cellsByColumn,
  });

  final String id;
  final String rangeLabel;
  final List<List<LegendCell>> cellsByColumn;
}

List<_LegendGridRow> _buildLegendRows(List<LegendCell> cells) {
  final byRange = groupBy(
    cells,
    (cell) => (cell.evasionRateStart, cell.evasionRateEnd),
  );
  final ranges = byRange.keys.sorted((a, b) => a.$1.compareTo(b.$1));

  return [
    for (final range in ranges)
      _LegendGridRow(
        id: '${range.$1}-${range.$2}',
        rangeLabel: range.$1 == range.$2
            ? '${range.$1}'
            : '${range.$1}〜${range.$2}',
        cellsByColumn: [
          for (var columnIndex = 0; columnIndex < _columnCount; columnIndex++)
            byRange[range]!
                .where((cell) => cell.columnIndex == columnIndex)
                .toList(),
        ],
      ),
  ];
}

/// Plain-text fallback used only for [TableEditor]'s column-width
/// measurement (see `valueOf`) — the actual on-screen rendering always
/// goes through [_LegendGridCell], which shows [LegendCell.sign] as an
/// icon rather than a hardcoded character.
String _legendCellText(LegendCell cell) {
  final label = cell.text ?? cell.textKey;
  return cell.liveValues.isEmpty
      ? label
      : '$label (${cell.liveValues.join(' / ')})';
}

List<TableEditorColumn<_LegendGridRow>> _buildLegendColumns({
  required String rangeColumnLabel,
}) {
  return [
    TableEditorColumn<_LegendGridRow>(
      key: 'range',
      label: rangeColumnLabel,
      valueOf: (row) => row.rangeLabel,
    ),
    for (var columnIndex = 0; columnIndex < _columnCount; columnIndex++)
      TableEditorColumn<_LegendGridRow>(
        key: 'v$columnIndex',
        label: '${columnIndex + 1}',
        valueOf: (row) =>
            row.cellsByColumn[columnIndex].map(_legendCellText).join(' / '),
        cellBuilder: (context, row) =>
            _LegendGridCell(cells: row.cellsByColumn[columnIndex]),
      ),
  ];
}

/// Wraps [child] in a highlight border or dimmed background — see
/// `PhysiqueLegendGridThemeData` — without altering [child] itself, so
/// the wrapped content (e.g. [TableEditor]'s own text styling) stays
/// exactly as it would render undecorated.
class _CellDecoration extends StatelessWidget {
  const _CellDecoration({required this.isMatch, required this.child});

  final bool isMatch;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).extension<PhysiqueLegendGridThemeData>()!;
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
      decoration: BoxDecoration(
        color: isMatch ? null : theme.dimmedBackgroundColor,
        border: isMatch
            ? Border.all(color: theme.highlightBorderColor, width: 2)
            : null,
      ),
      child: child,
    );
  }
}

/// One legend column's cell: every [LegendCell] sharing that
/// `(evasionRateRange, columnIndex)` slot, joined onto a single line (one
/// [TableEditor] row is a fixed height, so stacking candidates vertically
/// would overflow it) separated by `" / "`, each with its own plus/minus
/// icon inlined via [WidgetSpan] — matching how the candidate-selection
/// dialog represents `sign` (see `denpa_men_editor.dart`) — rather than a
/// hardcoded `+`/`-` character. Overflowing content is ellipsized rather
/// than clipped mid-glyph.
class _LegendGridCell extends StatelessWidget {
  const _LegendGridCell({required this.cells});

  final List<LegendCell> cells;

  @override
  Widget build(BuildContext context) {
    final style = DefaultTextStyle.of(context).style;
    return _CellDecoration(
      isMatch: cells.any((cell) => cell.isMatch),
      child: Text.rich(
        TextSpan(
          children: [
            for (var i = 0; i < cells.length; i++) ...[
              if (i > 0) const TextSpan(text: ' / '),
              WidgetSpan(
                alignment: PlaceholderAlignment.middle,
                child: EvasionRateSignIcon(sign: cells[i].sign, size: 14),
              ),
              TextSpan(text: _legendCellText(cells[i])),
            ],
          ],
          style: style,
        ),
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }
}
