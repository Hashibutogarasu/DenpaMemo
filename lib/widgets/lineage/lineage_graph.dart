import 'dart:async';
import 'dart:io';

import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:graphview/GraphView.dart';

import '../../domain/denpa_men/denpa_men.dart';
import '../../domain/denpa_men/denpa_men_record.dart';
import '../../domain/master_data/master_data.dart';
import '../../domain/qr_code/qr_code_record.dart';
import '../../providers/denpa_men_providers.dart';
import '../dialog/denpa_men_preview_dialog.dart';
import '../dialog/qr_code_image_dialog.dart';
import 'lineage_graph_builder.dart';
import 'lineage_graph_cursor_icon.dart';
import 'lineage_graph_data_snapshot.dart';
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
  int _generation = 0;
  late List<Object?> _dataSnapshotValue;
  final _hoveredBredId = ValueNotifier<String?>(null);
  final _selectionMode = ValueNotifier<bool>(false);
  final _selectedIds = ValueNotifier<Set<int>>({});
  Timer? _cursorHitTestTimer;
  final _bredNodeEntriesByNodeKey = <Object, (GlobalKey, String)>{};
  final _stackKey = GlobalKey();

  late LineageGraphData _graphData;
  late Widget _graphView;

  @override
  void initState() {
    super.initState();
    _selectionMode.value = ref.read(selectionModeProvider);
    _selectedIds.value = ref.read(selectedDenpaMenIdsProvider);
    _dataSnapshotValue = lineageDataSnapshot(
      widget.qrCodes,
      widget.denpaMenRecords,
    );
    _graphData = buildLineageGraphData(
      qrCodes: widget.qrCodes,
      denpaMenRecords: widget.denpaMenRecords,
    );
    _graphView = _buildGraphView();
    if (widget.cursorEnabled) {
      _startCursorHitTesting();
    }
  }

  @override
  void didUpdateWidget(covariant LineageGraph oldWidget) {
    super.didUpdateWidget(oldWidget);
    final newSnapshot = lineageDataSnapshot(
      widget.qrCodes,
      widget.denpaMenRecords,
    );
    if (!lineageDataSnapshotsEqual(newSnapshot, _dataSnapshotValue) ||
        widget.controller != oldWidget.controller) {
      _dataSnapshotValue = newSnapshot;
      _generation++;
      _bredNodeEntriesByNodeKey.clear();
      _graphData = buildLineageGraphData(
        qrCodes: widget.qrCodes,
        denpaMenRecords: widget.denpaMenRecords,
      );
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
    _hoveredBredId.dispose();
    _selectionMode.dispose();
    _selectedIds.dispose();
    super.dispose();
  }

  void _toggleSelected(int id) {
    final current = ref.read(selectedDenpaMenIdsProvider);
    ref.read(selectedDenpaMenIdsProvider.notifier).state =
        current.contains(id)
        ? (Set<int>.from(current)..remove(id))
        : (Set<int>.from(current)..add(id));
  }

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
    _hoveredBredId.value = null;
  }

  void _updateHoverFromCursor() {
    final stackBox = _stackKey.currentContext?.findRenderObject() as RenderBox?;
    if (stackBox == null || !stackBox.attached) {
      return;
    }
    final center = stackBox.localToGlobal(stackBox.size.center(Offset.zero));
    String? hoveredId;
    for (final (key, denpaMenId) in _bredNodeEntriesByNodeKey.values) {
      final nodeBox = key.currentContext?.findRenderObject() as RenderBox?;
      if (nodeBox == null || !nodeBox.attached) {
        continue;
      }
      final rect = nodeBox.localToGlobal(Offset.zero) & nodeBox.size;
      if (rect.contains(center)) {
        hoveredId = denpaMenId;
        break;
      }
    }
    _hoveredBredId.value = hoveredId;
  }

  void _setHoveredBredId(String? id) {
    if (widget.cursorEnabled) {
      return;
    }
    _hoveredBredId.value = id;
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
    final nodeInfoByKey = _graphData.nodeInfoByKey;
    final denpaMenById = _graphData.denpaMenById;

    return GraphView.builder(
      key: ValueKey(_generation),
      graph: _graphData.graph,
      algorithm: _graphData.algorithm,
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
                hoveredBredId: _hoveredBredId,
                denpaMenById: denpaMenById,
                incomingSourceKeysById: _graphData.incomingSourceKeysById,
                graphNodeKey: node.key!.value,
                selectionMode: _selectionMode,
                selectedIds: _selectedIds,
                onToggleSelection: _toggleSelected,
                onMiddleClick: _middleClickSelect,
                onTap: () => _showPreview(context, info.record!.denpaMen),
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
                hoveredBredId: _hoveredBredId,
                denpaMenById: denpaMenById,
                incomingSourceKeysById: _graphData.incomingSourceKeysById,
                graphNodeKey: node.key!.value,
                selectionMode: _selectionMode,
                selectedIds: _selectedIds,
                onToggleSelection: _toggleSelected,
                onMiddleClick: _middleClickSelect,
                onTap: () => _showPreview(context, info.record!.denpaMen),
                onHoverEnter: () => _setHoveredBredId(info.record!.denpaMen.id),
                onHoverExit: () => _setHoveredBredId(null),
                nodeKey: _bredNodeEntriesByNodeKey
                    .putIfAbsent(
                      node.key!.value,
                      () => (GlobalKey(), info.record!.denpaMen.id),
                    )
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
      (_, next) => _selectionMode.value = next,
    );
    ref.listen<Set<int>>(
      selectedDenpaMenIdsProvider,
      (_, next) => _selectedIds.value = next,
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
