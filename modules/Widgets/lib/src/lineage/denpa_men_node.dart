import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:tree_graph/tree_graph.dart';

/// [icon] with [name] shown below. [hoverHighlightPainter], when set,
/// paints via [Listenable] rather than a rebuild — see
/// [TreeNodeHighlightPainter]. [selectionMode]/[selectedIds]/[recordId],
/// when all set, show a selection overlay on top.
class DenpaMenNode extends StatelessWidget {
  const DenpaMenNode({
    super.key,
    required this.icon,
    required this.name,
    required this.size,
    this.hoverHighlightPainter,
    this.selectionMode,
    this.selectedIds,
    this.recordId,
    this.selectedOverlay,
  });

  final Widget icon;
  final String name;
  final double size;
  final CustomPainter? hoverHighlightPainter;
  final ValueListenable<bool>? selectionMode;
  final ValueListenable<Set<Object>>? selectedIds;
  final Object? recordId;
  final Widget? selectedOverlay;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Stack(
          clipBehavior: Clip.none,
          children: [
            icon,
            if (hoverHighlightPainter != null)
              Positioned.fill(
                child: CustomPaint(painter: hoverHighlightPainter),
              ),
            if (selectionMode != null &&
                selectedIds != null &&
                recordId != null &&
                selectedOverlay != null)
              Positioned.fill(
                child: TreeNodeSelectionOverlay(
                  selectionMode: selectionMode!,
                  selectedKeys: selectedIds!,
                  nodeKey: recordId!,
                  overlay: selectedOverlay!,
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
