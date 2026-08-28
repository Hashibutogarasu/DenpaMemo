import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

/// Shows [overlay] over a tree node when [selectionMode] is on and
/// [nodeKey] is in [selectedKeys]. Stays mounted and only toggles via
/// [Opacity]/[IgnorePointer], since inserting/removing it under a
/// GraphView node would force the whole graph to relayout.
class TreeNodeSelectionOverlay extends StatelessWidget {
  const TreeNodeSelectionOverlay({
    super.key,
    required this.selectionMode,
    required this.selectedKeys,
    required this.nodeKey,
    required this.overlay,
  });

  final ValueListenable<bool> selectionMode;
  final ValueListenable<Set<Object>> selectedKeys;
  final Object nodeKey;
  final Widget overlay;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
      valueListenable: selectionMode,
      builder: (context, mode, child) {
        return ValueListenableBuilder<Set<Object>>(
          valueListenable: selectedKeys,
          builder: (context, keys, child) {
            final visible = mode && keys.contains(nodeKey);
            return IgnorePointer(
              ignoring: !visible,
              child: Opacity(opacity: visible ? 1 : 0, child: child),
            );
          },
          child: child,
        );
      },
      child: overlay,
    );
  }
}
