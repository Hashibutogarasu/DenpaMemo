import 'dart:async';

import 'package:flutter/material.dart';
import 'package:graphview/GraphView.dart';

import 'tree_graph_controller.dart';

typedef TreeNodeBuilder<T, G> =
    Widget Function(BuildContext context, Object nodeKey, T? data, G? groupData);

/// Renders [controller]'s graph, delegating node content to
/// [nodeBuilder]. [visualRefreshToken] forces a fresh builder instance
/// (e.g. after icons load) without a structural rebuild.
class TreeGraphView<T, G> extends StatefulWidget {
  const TreeGraphView({
    super.key,
    required this.controller,
    required this.nodeBuilder,
    this.nodeSize = 64,
    this.graphViewController,
    this.cursorEnabled = false,
    this.overlay,
    this.onHoveredChanged,
    this.visualRefreshToken,
    this.cursorHitTestInterval = const Duration(milliseconds: 200),
  });

  final TreeGraphController<T, G> controller;
  final TreeNodeBuilder<T, G> nodeBuilder;
  final double nodeSize;
  final GraphViewController? graphViewController;
  final bool cursorEnabled;
  final Widget? overlay;
  final void Function(Object? nodeKey, T? data)? onHoveredChanged;
  final Object? visualRefreshToken;
  final Duration cursorHitTestInterval;

  @override
  State<TreeGraphView<T, G>> createState() => _TreeGraphViewState<T, G>();
}

class _TreeGraphViewState<T, G> extends State<TreeGraphView<T, G>> {
  Timer? _cursorHitTestTimer;
  final _stackKey = GlobalKey();
  late int _lastSeenGeneration;
  late Widget _graphView;

  @override
  void initState() {
    super.initState();
    _lastSeenGeneration = widget.controller.generation;
    _graphView = _buildGraphView();
    if (widget.cursorEnabled) {
      _startCursorHitTesting();
    }
  }

  @override
  void didUpdateWidget(covariant TreeGraphView<T, G> oldWidget) {
    super.didUpdateWidget(oldWidget);
    final generationChanged = widget.controller.generation != _lastSeenGeneration;
    final controllerChanged = widget.controller != oldWidget.controller;
    final refreshTokenChanged = widget.visualRefreshToken != oldWidget.visualRefreshToken;
    if (generationChanged || controllerChanged || refreshTokenChanged) {
      _lastSeenGeneration = widget.controller.generation;
      _graphView = _buildGraphView();
    }
    if (widget.cursorEnabled != oldWidget.cursorEnabled) {
      if (widget.cursorEnabled) {
        _startCursorHitTesting();
      } else {
        _stopCursorHitTesting();
      }
    }
  }

  @override
  void dispose() {
    _cursorHitTestTimer?.cancel();
    super.dispose();
  }

  void _startCursorHitTesting() {
    _cursorHitTestTimer?.cancel();
    _cursorHitTestTimer = Timer.periodic(
      widget.cursorHitTestInterval,
      (_) => _updateHoverFromCursor(),
    );
  }

  void _stopCursorHitTesting() {
    _cursorHitTestTimer?.cancel();
    _cursorHitTestTimer = null;
    widget.onHoveredChanged?.call(null, null);
  }

  void _updateHoverFromCursor() {
    final stackBox = _stackKey.currentContext?.findRenderObject() as RenderBox?;
    if (stackBox == null || !stackBox.attached) {
      return;
    }
    final center = stackBox.localToGlobal(stackBox.size.center(Offset.zero));
    Object? hoveredKey;
    T? hoveredData;
    for (final entry in widget.controller.nodeEntriesByKey.entries) {
      final (nodeKey, data) = entry.value;
      final nodeBox = nodeKey.currentContext?.findRenderObject() as RenderBox?;
      if (nodeBox == null || !nodeBox.attached) {
        continue;
      }
      final rect = nodeBox.localToGlobal(Offset.zero) & nodeBox.size;
      if (rect.contains(center)) {
        hoveredKey = entry.key;
        hoveredData = data;
        break;
      }
    }
    widget.onHoveredChanged?.call(hoveredKey, hoveredData);
  }

  Widget _buildGraphView() {
    final graphData = widget.controller.graphData;
    return GraphView.builder(
      key: ValueKey(widget.controller.generation),
      graph: graphData.graph,
      algorithm: graphData.algorithm,
      controller: widget.graphViewController,
      autoZoomToFit: true,
      centerGraph: true,
      builder: (node) {
        final key = node.key!.value;
        final data = graphData.nodeDataByKey[key];
        final groupData = graphData.groupDataByKey[key];
        return RepaintBoundary(
          child: widget.nodeBuilder(context, key, data, groupData),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      key: _stackKey,
      children: [_graphView, if (widget.overlay != null) widget.overlay!],
    );
  }
}
