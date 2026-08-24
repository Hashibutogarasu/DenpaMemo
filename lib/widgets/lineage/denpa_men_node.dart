import 'dart:io';

import 'package:flutter/material.dart';

import '../icon/entity_icon.dart';
import 'catch_order_badge.dart';
import 'lineage_node_highlight_painter.dart';

/// A `DenpaMen` node in
/// [DenpaMenLineageTree](../denpa_men_lineage_tree.dart): [iconFile]'s
/// image (or a placeholder if it's null), with its name shown below. The
/// icon is resolved by the caller ahead of time — rather than watched
/// here — so the graph lays out once and doesn't reflow node-by-node as
/// each icon finishes loading. When [catchIndex] is set, it's overlaid in
/// the icon's bottom-right corner; null omits the badge.
/// [hoverHighlightPainter], when set, paints a hover-highlight border and
/// catch-order badge on top, driven by a [Listenable] rather than a
/// rebuild — see [LineageNodeHighlightPainter].
class DenpaMenNode extends StatelessWidget {
  const DenpaMenNode({
    super.key,
    required this.iconFile,
    required this.name,
    required this.size,
    this.catchIndex,
    this.hoverHighlightPainter,
  });

  final File? iconFile;
  final String name;
  final double size;
  final int? catchIndex;
  final LineageNodeHighlightPainter? hoverHighlightPainter;

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
            if (catchIndex != null)
              Positioned(
                right: 4,
                bottom: 4,
                child: CatchOrderBadge(value: catchIndex!),
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
