import 'package:flutter/material.dart';

/// Fixed at the center of [LineageGraph](lineage_graph.dart) while
/// [LineageGraph.cursorEnabled] is on, standing in for a mouse cursor on
/// touch devices — the node it lands on is treated as hovered.
class LineageGraphCursorIcon extends StatelessWidget {
  const LineageGraphCursorIcon({super.key});

  @override
  Widget build(BuildContext context) {
    return const IgnorePointer(
      child: Center(child: Icon(Icons.add, size: 32, color: Colors.black54)),
    );
  }
}
