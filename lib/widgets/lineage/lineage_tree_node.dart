import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../domain/denpa_men/denpa_men.dart';
import '../../domain/master_data/master_data.dart';
import '../dialog/denpa_men_action_menu.dart';
import '../middle_click_detector.dart';
import 'denpa_men_node.dart';
import 'lineage_node_highlight_painter.dart';
import 'node_info.dart';

/// A single [NodeKind.caughtDenpaMen] or [NodeKind.bredDenpaMen] tile in
/// [LineageGraph](lineage_graph.dart): shows [info]'s [DenpaMenNode],
/// wired to a [LineageNodeHighlightPainter] so hovering another node
/// highlights this one without ever rebuilding it — see that painter's
/// doc comment for why a rebuild isn't an option here. For a bred
/// individual, reports hover in/out via [onHoverEnter] / [onHoverExit].
/// While [selectionMode] is true, tapping toggles selection (via
/// [onToggleSelection]) instead of calling [onTap]; middle-clicking
/// always toggles selection via [onMiddleClick], regardless of
/// [selectionMode].
class LineageTreeNode extends StatelessWidget {
  const LineageTreeNode({
    super.key,
    required this.info,
    required this.masterData,
    required this.iconFile,
    required this.nodeSize,
    required this.isBred,
    required this.hoveredBredId,
    required this.denpaMenById,
    required this.incomingSourceKeysById,
    required this.graphNodeKey,
    required this.selectionMode,
    required this.selectedIds,
    required this.onToggleSelection,
    required this.onMiddleClick,
    required this.onTap,
    this.onHoverEnter,
    this.onHoverExit,
    this.nodeKey,
  });

  final NodeInfo info;
  final MasterData masterData;
  final File? iconFile;
  final double nodeSize;
  final bool isBred;
  final ValueListenable<String?> hoveredBredId;
  final Map<String, DenpaMen> denpaMenById;
  final Map<String, List<Object>> incomingSourceKeysById;
  final Object graphNodeKey;
  final ValueListenable<bool> selectionMode;
  final ValueListenable<Set<int>> selectedIds;
  final ValueChanged<int> onToggleSelection;
  final ValueChanged<int> onMiddleClick;
  final VoidCallback onTap;
  final VoidCallback? onHoverEnter;
  final VoidCallback? onHoverExit;
  final GlobalKey? nodeKey;

  void _handleTap() {
    if (selectionMode.value) {
      onToggleSelection(info.record!.id);
    } else {
      onTap();
    }
  }

  @override
  Widget build(BuildContext context) {
    final content = DenpaMenContextMenuArea(
      key: nodeKey,
      record: info.record!,
      masterData: masterData,
      child: MiddleClickDetector(
        onMiddleClick: () => onMiddleClick(info.record!.id),
        child: GestureDetector(
          onTap: _handleTap,
          child: DenpaMenNode(
            iconFile: iconFile,
            name: info.name!,
            hoverHighlightPainter: LineageNodeHighlightPainter(
              nodeKey: graphNodeKey,
              denpaMenId: info.record!.denpaMen.id,
              denpaMenById: denpaMenById,
              incomingSourceKeysById: incomingSourceKeysById,
              hoveredBredId: hoveredBredId,
            ),
            size: nodeSize,
            selectionMode: selectionMode,
            selectedIds: selectedIds,
            recordId: info.record!.id,
          ),
        ),
      ),
    );

    if (!isBred) {
      return content;
    }
    return MouseRegion(
      onEnter: (_) => onHoverEnter?.call(),
      onExit: (_) => onHoverExit?.call(),
      child: content,
    );
  }
}
