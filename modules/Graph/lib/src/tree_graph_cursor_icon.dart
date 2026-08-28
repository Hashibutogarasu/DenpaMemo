import 'package:flutter/material.dart';

/// Fixed at the center of a [TreeGraphView] while its `cursorEnabled` is
/// on, standing in for a mouse cursor on touch devices — the node it
/// lands on is treated as hovered.
class TreeGraphCursorIcon extends StatelessWidget {
  const TreeGraphCursorIcon({super.key});

  @override
  Widget build(BuildContext context) {
    return const IgnorePointer(
      child: Center(child: Icon(Icons.add, size: 32, color: Colors.black54)),
    );
  }
}
