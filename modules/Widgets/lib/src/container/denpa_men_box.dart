import 'dart:io';
import 'dart:math' as math;

import 'package:data_pack/data_pack.dart';
import 'package:flutter/material.dart';

import '../denpa_men_container.dart';

/// Scrollable icon grid of [DenpaMenRecord]s, laid out with
/// [DenpaMenContainer] cells. Used as the grid alternative to the home
/// screen's list-tile display (see `HomeTileMode.grid` in
/// `home_view_providers.dart`).
///
/// Virtualized via [CustomScrollView] and [SliverGrid] since the record
/// count can reach into the hundreds, unlike the small fixed-size grids
/// elsewhere in the app (e.g. `EditableStatGrid`). [trailing] lets a
/// caller append a footer (a load-more spinner or an end-of-list
/// message) inside the same scrollable, e.g. to drive pagination from
/// outside without this widget knowing about it.
class DenpaMenBox extends StatelessWidget {
  const DenpaMenBox({
    super.key,
    required this.records,
    required this.selectionMode,
    required this.selectedIds,
    required this.cutIds,
    required this.onSelectedChanged,
    required this.onTapRecord,
    this.iconsById = const {},
    this.zoomCandidatesById = const {},
    this.columns,
    this.itemSize = 56,
    this.gap = 8,
    this.padding = EdgeInsets.zero,
    this.trailing,
  });

  final List<DenpaMenRecord> records;
  final bool selectionMode;
  final Set<int> selectedIds;
  final Set<int> cutIds;
  final void Function(int id, bool selected) onSelectedChanged;
  final ValueChanged<DenpaMen> onTapRecord;
  final Map<String, File?> iconsById;
  final Map<String, List<DenpaMenZoomCandidate>> zoomCandidatesById;

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
                delegate: SliverChildBuilderDelegate((context, index) {
                  final record = records[index];
                  return Opacity(
                    opacity: cutIds.contains(record.id) ? 0.5 : 1,
                    child: DenpaMenContainer(
                      denpaMen: record.denpaMen,
                      selectionMode: selectionMode,
                      selected: selectedIds.contains(record.id),
                      onSelectedChanged: (selected) =>
                          onSelectedChanged(record.id, selected),
                      onTap: () => onTapRecord(record.denpaMen),
                      enableLongPressPreview: false,
                      iconFile: iconsById[record.denpaMen.id],
                      zoomCandidates: zoomCandidatesById[record.denpaMen.id],
                      size: itemSize,
                    ),
                  );
                }, childCount: records.length),
              ),
            ),
            if (trailing != null) SliverToBoxAdapter(child: trailing),
          ],
        );
      },
    );
  }
}
