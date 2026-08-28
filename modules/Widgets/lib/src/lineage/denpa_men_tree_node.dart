import 'dart:io';

import 'package:data_pack/data_pack.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:tree_graph/tree_graph.dart';

import '../denpa_men_selected_overlay.dart';
import '../middle_click_detector.dart';
import 'denpa_men_highlight_strategy.dart';
import 'denpa_men_node.dart';
import 'denpa_men_node_data.dart';

/// One tree node in `DenpaMenLineageGraph`. While [selectionMode] is
/// true, tapping toggles selection via [onToggleSelection] instead of
/// calling [onTap]; middle-clicking always toggles selection via
/// [onMiddleClick]. [nodeKey] lands on the outermost widget, so cursor
/// hit-testing measures the whole node including [contextMenuBuilder]'s
/// wrapper.
class DenpaMenTreeNode extends StatelessWidget {
  const DenpaMenTreeNode({
    super.key,
    required this.data,
    required this.iconFile,
    required this.nodeSize,
    required this.hoveredKey,
    required this.dataByKey,
    required this.denpaMenById,
    required this.incomingSourceKeysByKey,
    required this.graphNodeKey,
    required this.selectionMode,
    required this.selectedIds,
    required this.onToggleSelection,
    required this.onMiddleClick,
    required this.onTap,
    this.contextMenuBuilder,
    this.onHoverEnter,
    this.onHoverExit,
    this.nodeKey,
  });

  final DenpaMenNodeData data;
  final File? iconFile;
  final double nodeSize;
  final ValueListenable<Object?> hoveredKey;
  final Map<Object, DenpaMenNodeData> dataByKey;
  final Map<String, DenpaMen> denpaMenById;
  final Map<Object, List<Object>> incomingSourceKeysByKey;
  final Object graphNodeKey;
  final ValueListenable<bool> selectionMode;
  final ValueListenable<Set<Object>> selectedIds;
  final ValueChanged<int> onToggleSelection;
  final ValueChanged<int> onMiddleClick;
  final VoidCallback onTap;
  final Widget Function(BuildContext context, DenpaMenRecord record, Widget child)?
  contextMenuBuilder;
  final VoidCallback? onHoverEnter;
  final VoidCallback? onHoverExit;
  final GlobalKey? nodeKey;

  void _handleTap() {
    if (selectionMode.value) {
      onToggleSelection(data.record.id);
    } else {
      onTap();
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget content = MiddleClickDetector(
      onMiddleClick: () => onMiddleClick(data.record.id),
      child: GestureDetector(
        onTap: _handleTap,
        child: DenpaMenNode(
          iconFile: iconFile,
          name: data.record.denpaMen.name,
          hoverHighlightPainter: TreeNodeHighlightPainter<DenpaMenNodeData>(
            nodeKey: graphNodeKey,
            specKey: data.record.denpaMen.id,
            dataByKey: dataByKey,
            incomingSourceKeysByKey: incomingSourceKeysByKey,
            hoveredKey: hoveredKey,
            strategy: DenpaMenHighlightStrategy(denpaMenById: denpaMenById),
          ),
          size: nodeSize,
          selectionMode: selectionMode,
          selectedIds: selectedIds,
          recordId: data.record.id,
          selectedOverlay: const DenpaMenSelectedOverlay(),
        ),
      ),
    );

    if (contextMenuBuilder != null) {
      content = contextMenuBuilder!(context, data.record, content);
    }
    content = KeyedSubtree(key: nodeKey, child: content);

    if (!data.isBred) {
      return content;
    }
    return MouseRegion(
      onEnter: (_) => onHoverEnter?.call(),
      onExit: (_) => onHoverExit?.call(),
      child: content,
    );
  }
}
