import 'dart:math' as math;

import 'package:flutter/material.dart';

import 'package:data_pack/data_pack.dart';

/// Scrollable icon grid of [DenpaMenRecord]s. Used as the grid alternative
/// to the home screen's list-tile display (see `HomeTileMode.grid` in
/// `home_view_providers.dart`).
///
/// Virtualized via [CustomScrollView] and [SliverGrid] since the record
/// count can reach into the hundreds, unlike the small fixed-size grids
/// elsewhere in the app (e.g. `EditableStatGrid`). [cellBuilder] builds
/// each cell's full content (icon, selection, tap handling) for one
/// [DenpaMenRecord] at the given cell size — called lazily by
/// [SliverChildBuilderDelegate] only for cells actually realized near the
/// viewport, so a caller resolving each cell's icon from a provider (e.g.
/// wrapping a [ConsumerWidget]) only ever watches providers for the
/// records currently on screen, not the whole (possibly paginated) list.
/// [trailing] lets a caller append a footer (a load-more spinner or an
/// end-of-list message) inside the same scrollable, e.g. to drive
/// pagination from outside without this widget knowing about it.
class DenpaMenBox extends StatelessWidget {
  const DenpaMenBox({
    super.key,
    required this.records,
    required this.cellBuilder,
    this.columns,
    this.itemSize = 56,
    this.gap = 8,
    this.padding = EdgeInsets.zero,
    this.trailing,
  });

  final List<DenpaMenRecord> records;
  final Widget Function(
    BuildContext context,
    DenpaMenRecord record,
    double cellSize,
  )
  cellBuilder;

  /// Fixed column count. When null, the column count is derived from the
  /// available width, [itemSize], and [gap] instead.
  final int? columns;
  final double itemSize;
  final double gap;
  final EdgeInsetsGeometry padding;

  final Widget? trailing;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final resolvedColumns =
            columns ??
            math.max(
              1,
              ((constraints.maxWidth + gap) / (itemSize + gap)).floor(),
            );

        return CustomScrollView(
          slivers: [
            SliverPadding(
              padding: padding,
              sliver: SliverGrid(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: resolvedColumns,
                  mainAxisSpacing: gap,
                  crossAxisSpacing: gap,
                ),
                delegate: SliverChildBuilderDelegate(
                  (context, index) =>
                      cellBuilder(context, records[index], itemSize),
                  childCount: records.length,
                ),
              ),
            ),
            if (trailing != null) SliverToBoxAdapter(child: trailing),
          ],
        );
      },
    );
  }
}
