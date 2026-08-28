import 'dart:async';
import 'dart:io';

import 'package:collection/collection.dart';
import 'package:data_pack/data_pack.dart';
import 'package:denpamemo_widgets/denpamemo_widgets.dart' hide BuildContextTranslationsExtension;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:graphview/GraphView.dart';

import '../../providers/denpa_men_providers.dart';
import '../dialog/denpa_men_preview_dialog.dart';
import 'lineage_graph_controller.dart';
import 'lineage_graph_cursor_icon.dart';
import 'lineage_tree_node.dart';
import 'node_info.dart';
import 'qr_code_node.dart';

const _cursorHitTestInterval = Duration(milliseconds: 200);

class LineageGraph extends ConsumerStatefulWidget {
  const LineageGraph({
    super.key,
    required this.qrCodes,
    required this.denpaMenRecords,
    required this.masterData,
    required this.iconsById,
    this.controller,
    this.cursorEnabled = false,
  });

  final List<QrCodeRecord> qrCodes;
  final List<DenpaMenRecord> denpaMenRecords;
  final MasterData masterData;
  final Map<String, File?> iconsById;
  final GraphViewController? controller;
  final bool cursorEnabled;

  @override
  ConsumerState<LineageGraph> createState() => _LineageGraphState();
}

class _LineageGraphState extends ConsumerState<LineageGraph> {
  bool _qrDialogOpen = false;
  Timer? _cursorHitTestTimer;
  final _stackKey = GlobalKey();

  late final _controller = LineageGraphController(
    qrCodes: widget.qrCodes,
    denpaMenRecords: widget.denpaMenRecords,
  );
  late Widget _graphView;

  @override
  void initState() {
    super.initState();
    _controller.selectionMode.value = ref.read(selectionModeProvider);
    _controller.selectedIds.value = ref.read(selectedDenpaMenIdsProvider);
    _graphView = _buildGraphView();
    if (widget.cursorEnabled) {
      _startCursorHitTesting();
    }
  }

  @override
  void didUpdateWidget(covariant LineageGraph oldWidget) {
    super.didUpdateWidget(oldWidget);
    final dataChanged = _controller.refreshIfChanged(
      widget.qrCodes,
      widget.denpaMenRecords,
    );
    final controllerChanged = widget.controller != oldWidget.controller;
    if (dataChanged || controllerChanged) {
      if (!dataChanged) {
        _controller.forceRefresh(widget.qrCodes, widget.denpaMenRecords);
      }
      _graphView = _buildGraphView();
    } else if (!const MapEquality<String, File?>().equals(
      widget.iconsById,
      oldWidget.iconsById,
    )) {
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
    _controller.dispose();
    super.dispose();
  }

  void _toggleSelected(int id) => toggleDenpaMenSelection(ref, id);

  void _middleClickSelect(int id) {
    ref.read(selectionModeProvider.notifier).state = true;
    _toggleSelected(id);
  }

  void _startCursorHitTesting() {
    _cursorHitTestTimer?.cancel();
    _cursorHitTestTimer = Timer.periodic(
      _cursorHitTestInterval,
      (_) => _updateHoverFromCursor(),
    );
  }

  void _stopCursorHitTesting() {
    _cursorHitTestTimer?.cancel();
    _cursorHitTestTimer = null;
    _controller.hoveredBredId.value = null;
    ref.read(hoveredTreeRecordIdProvider.notifier).state = null;
  }

  void _updateHoverFromCursor() {
    final stackBox = _stackKey.currentContext?.findRenderObject() as RenderBox?;
    if (stackBox == null || !stackBox.attached) {
      return;
    }
    final center = stackBox.localToGlobal(stackBox.size.center(Offset.zero));
    String? hoveredBredId;
    int? hoveredRecordId;
    for (final (key, info) in _controller.nodeEntriesByNodeKey.values) {
      final nodeBox = key.currentContext?.findRenderObject() as RenderBox?;
      if (nodeBox == null || !nodeBox.attached) {
        continue;
      }
      final rect = nodeBox.localToGlobal(Offset.zero) & nodeBox.size;
      if (rect.contains(center)) {
        hoveredRecordId = info.record!.id;
        if (info.kind == NodeKind.bredDenpaMen) {
          hoveredBredId = info.record!.denpaMen.id;
        }
        break;
      }
    }
    _controller.hoveredBredId.value = hoveredBredId;
    ref.read(hoveredTreeRecordIdProvider.notifier).state = hoveredRecordId;
  }

  void _setHoveredBredId(String? id) {
    if (widget.cursorEnabled) {
      return;
    }
    _controller.hoveredBredId.value = id;
  }

  void _showPreview(BuildContext context, DenpaMen denpaMen) {
    DenpaMenPreviewDialog.show(context, denpaMen: denpaMen);
  }

  Future<void> _showQrCodeImage(BuildContext context, String rawValue) async {
    setState(() {
      _qrDialogOpen = true;
      _graphView = _buildGraphView();
    });
    await showDialog<void>(
      context: context,
      builder: (context) => QrCodeImageDialog(rawValue: rawValue),
    );
    if (mounted) {
      setState(() {
        _qrDialogOpen = false;
        _graphView = _buildGraphView();
      });
    }
  }

  Widget _buildGraphView() {
    const nodeSize = 64.0;
    final nodeInfoByKey = _controller.graphData.nodeInfoByKey;
    final denpaMenById = _controller.graphData.denpaMenById;

    return GraphView.builder(
      key: ValueKey(_controller.generation),
      graph: _controller.graphData.graph,
      algorithm: _controller.graphData.algorithm,
      controller: widget.controller,
      autoZoomToFit: true,
      centerGraph: true,
      builder: (node) {
        final info = nodeInfoByKey[node.key!.value];
        return RepaintBoundary(
          child: switch (info?.kind) {
            NodeKind.qrCode =>
              _qrDialogOpen
                  ? SizedBox(width: nodeSize, height: nodeSize)
                  : Builder(
                      builder: (context) => GestureDetector(
                        onTap: () => _showQrCodeImage(context, info.rawValue!),
                        child: QrCodeNode(
                          rawValue: info!.rawValue!,
                          size: nodeSize,
                        ),
                      ),
                    ),
            NodeKind.caughtDenpaMen => Builder(
              builder: (context) => LineageTreeNode(
                key: ValueKey(node.key!.value),
                info: info!,
                masterData: widget.masterData,
                iconFile: widget.iconsById[info.record!.denpaMen.id],
                nodeSize: nodeSize,
                isBred: false,
                hoveredBredId: _controller.hoveredBredId,
                denpaMenById: denpaMenById,
                incomingSourceKeysById: _controller.graphData.incomingSourceKeysById,
                graphNodeKey: node.key!.value,
                selectionMode: _controller.selectionMode,
                selectedIds: _controller.selectedIds,
                onToggleSelection: _toggleSelected,
                onMiddleClick: _middleClickSelect,
                onTap: () => _showPreview(context, info.record!.denpaMen),
                nodeKey: _controller.nodeEntriesByNodeKey
                    .putIfAbsent(node.key!.value, () => (GlobalKey(), info))
                    .$1,
              ),
            ),
            NodeKind.bredDenpaMen => Builder(
              builder: (context) => LineageTreeNode(
                key: ValueKey(node.key!.value),
                info: info!,
                masterData: widget.masterData,
                iconFile: widget.iconsById[info.record!.denpaMen.id],
                nodeSize: nodeSize,
                isBred: true,
                hoveredBredId: _controller.hoveredBredId,
                denpaMenById: denpaMenById,
                incomingSourceKeysById: _controller.graphData.incomingSourceKeysById,
                graphNodeKey: node.key!.value,
                selectionMode: _controller.selectionMode,
                selectedIds: _controller.selectedIds,
                onToggleSelection: _toggleSelected,
                onMiddleClick: _middleClickSelect,
                onTap: () => _showPreview(context, info.record!.denpaMen),
                onHoverEnter: () => _setHoveredBredId(info.record!.denpaMen.id),
                onHoverExit: () => _setHoveredBredId(null),
                nodeKey: _controller.nodeEntriesByNodeKey
                    .putIfAbsent(node.key!.value, () => (GlobalKey(), info))
                    .$1,
              ),
            ),
            NodeKind.invisible ||
            null => SizedBox(width: nodeSize, height: nodeSize),
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    ref.listen<bool>(
      selectionModeProvider,
      (_, next) => _controller.selectionMode.value = next,
    );
    ref.listen<Set<int>>(
      selectedDenpaMenIdsProvider,
      (_, next) => _controller.selectedIds.value = next,
    );
    return Stack(
      key: _stackKey,
      children: [
        _graphView,
        if (widget.cursorEnabled) const LineageGraphCursorIcon(),
      ],
    );
  }
}
