import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../icon/entity_icon.dart';
import 'lineage_node_highlight_painter.dart';
import 'lineage_node_selection_overlay.dart';

/// A `DenpaMen` node in
/// [DenpaMenLineageTree](../denpa_men_lineage_tree.dart): [iconFile]'s
/// image (or a placeholder if it's null), with its name shown below.
/// The icon is resolved by the caller ahead of time — rather than watched
/// here — so the graph lays out once and doesn't reflow node-by-node as
/// each icon finishes loading. [hoverHighlightPainter], when set, paints
/// the catch-order badge (the node's own when idle, the hovered
/// individual's resolved one when highlighted as its parent) and a
/// hover-highlight border on top, driven by a [Listenable] rather than a
/// rebuild — see [LineageNodeHighlightPainter]. [selectionMode],
/// [selectedIds], and [recordId], when all set, show
/// [LineageNodeSelectionOverlay] on top.
class DenpaMenNode extends StatelessWidget {
  const DenpaMenNode({
    super.key,
    required this.iconFile,
    required this.name,
    required this.size,
    this.hoverHighlightPainter,
    this.selectionMode,
    this.selectedIds,
    this.recordId,
  });

  final File? iconFile;
  final String name;
  final double size;
  final LineageNodeHighlightPainter? hoverHighlightPainter;
  final ValueListenable<bool>? selectionMode;
  final ValueListenable<Set<int>>? selectedIds;
  final int? recordId;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Stack(
          clipBehavior: Clip.none,
          children: [
            ResolvedEntityIcon(file: iconFile, size: size),
            if (hoverHighlightPainter != null)
              Positioned.fill(
                child: CustomPaint(painter: hoverHighlightPainter),
              ),
            if (selectionMode != null &&
                selectedIds != null &&
                recordId != null)
              Positioned.fill(
                child: LineageNodeSelectionOverlay(
                  selectionMode: selectionMode!,
                  selectedIds: selectedIds!,
                  recordId: recordId!,
                ),
              ),
          ],
        ),
        SizedBox(
          width: size,
          child: Text(
            name,
            textAlign: TextAlign.center,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}
