import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../denpa_men_selected_overlay.dart';

/// Shows [DenpaMenSelectedOverlay] over a lineage tree node when [selectionMode]
/// is on and [recordId] is in [selectedIds], reacting to both via nested
/// [ValueListenableBuilder]s rather than a widget rebuild — GraphView only
/// calls its node builder once per node (see
/// [LineageNodeHighlightPainter](lineage_node_highlight_painter.dart)'s
/// doc comment for why that rules out a rebuild here). [DenpaMenSelectedOverlay]
/// stays mounted at all times and is only ever hidden via [Opacity]/
/// [IgnorePointer] — swapping it for a differently-typed widget (e.g.
/// [SizedBox.shrink]) would insert/remove a render object under a GraphView
/// node, which forces the whole graph to relayout (nodes get loose
/// constraints, so this doesn't stay contained to one node) and makes the
/// tree appear to vanish.
class LineageNodeSelectionOverlay extends StatelessWidget {
  const LineageNodeSelectionOverlay({
    super.key,
    required this.selectionMode,
    required this.selectedIds,
    required this.recordId,
  });

  final ValueListenable<bool> selectionMode;
  final ValueListenable<Set<int>> selectedIds;
  final int recordId;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
      valueListenable: selectionMode,
      builder: (context, mode, child) {
        return ValueListenableBuilder<Set<int>>(
          valueListenable: selectedIds,
          builder: (context, ids, child) {
            final visible = mode && ids.contains(recordId);
            return IgnorePointer(
              ignoring: !visible,
              child: Opacity(opacity: visible ? 1 : 0, child: child),
            );
          },
          child: child,
        );
      },
      child: const DenpaMenSelectedOverlay(),
    );
  }
}
