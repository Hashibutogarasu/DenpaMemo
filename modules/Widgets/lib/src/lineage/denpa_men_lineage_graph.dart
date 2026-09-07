import 'package:flutter/material.dart';

import 'package:collection/collection.dart';
import 'package:data_pack/data_pack.dart';
import 'package:graphview/GraphView.dart';
import 'package:tree_graph/tree_graph.dart';

import '../dialog/app_dialog.dart';
import '../dialog/qr_code_image_dialog.dart';
import '../icon/denpa_men_icon_builder.dart';
import 'denpa_men_node_data.dart';
import 'denpa_men_tree_node.dart';
import 'qr_code_node.dart';

List<Object?> _snapshot(
  List<TreeGroupSpec<QrCodeGroupData>> groups,
  List<TreeNodeSpec<DenpaMenNodeData>> nodes,
) {
  final groupKeys = groups
      .map((g) => g.key)
      .sorted((a, b) => a.toString().compareTo(b.toString()));
  final nodeSignatures = nodes
      .map(
        (n) => (
          n.key,
          n.groupKey,
          n.parentKeys,
          n.data.record.denpaMen.name,
          n.data.isBred,
        ),
      )
      .sortedBy((s) => s.$1.toString());
  return [groupKeys, nodeSignatures];
}

List<TreeGroupSpec<QrCodeGroupData>> _groupsOf(List<QrCodeRecord> qrCodes) => [
  for (final qrCodeRecord in qrCodes)
    TreeGroupSpec(
      key: 'qr:${qrCodeRecord.qrCode.id}',
      data: QrCodeGroupData(rawValue: qrCodeRecord.qrCode.rawValue),
    ),
];

List<TreeNodeSpec<DenpaMenNodeData>> _nodesOf(
  List<DenpaMenRecord> denpaMenRecords,
) => [
  for (final record in denpaMenRecords)
    TreeNodeSpec(
      key: record.denpaMen.id,
      data: DenpaMenNodeData(
        record: record,
        isBred: record.denpaMen.parentIds.isNotEmpty,
      ),
      parentKeys: record.denpaMen.parentIds,
      groupKey: record.denpaMen.parentIds.isEmpty
          ? 'qr:${record.denpaMen.qrCodeId}'
          : null,
    ),
];

/// Shows every [qrCodes] entry as the root of a tree, in a single shared
/// canvas: individuals caught directly under it (ordered by catch order),
/// then any bred descendants — connected with an edge from each of its
/// (up to two) parents, so shared offspring visibly converge.
class DenpaMenLineageGraph extends StatefulWidget {
  const DenpaMenLineageGraph({
    super.key,
    required this.qrCodes,
    required this.denpaMenRecords,
    this.iconBuilder,
    required this.selectionMode,
    required this.selectedIds,
    required this.onToggleSelection,
    required this.onMiddleClickSelect,
    required this.onTapNode,
    this.onHoveredRecordChanged,
    this.contextMenuBuilder,
    this.graphViewController,
    this.cursorEnabled = false,
  });

  final List<QrCodeRecord> qrCodes;
  final List<DenpaMenRecord> denpaMenRecords;
  final Widget Function(String denpaMenId, double size)? iconBuilder;
  final bool selectionMode;
  final Set<int> selectedIds;
  final ValueChanged<int> onToggleSelection;
  final ValueChanged<int> onMiddleClickSelect;
  final void Function(BuildContext context, DenpaMen denpaMen) onTapNode;
  final ValueChanged<int?>? onHoveredRecordChanged;
  final Widget Function(
    BuildContext context,
    DenpaMenRecord record,
    Widget child,
  )?
  contextMenuBuilder;
  final GraphViewController? graphViewController;
  final bool cursorEnabled;

  @override
  State<DenpaMenLineageGraph> createState() => _DenpaMenLineageGraphState();
}

class _DenpaMenLineageGraphState extends State<DenpaMenLineageGraph> {
  bool _qrDialogOpen = false;

  late final _controller =
      TreeGraphController<DenpaMenNodeData, QrCodeGroupData>(
        groups: _groupsOf(widget.qrCodes),
        nodes: _nodesOf(widget.denpaMenRecords),
        snapshotOf: _snapshot,
        siblingOrder: _compareSiblings,
      );

  Map<String, DenpaMen> get _denpaMenById => {
    for (final record in widget.denpaMenRecords)
      record.denpaMen.id: record.denpaMen,
  };

  int _compareSiblings(
    TreeNodeSpec<DenpaMenNodeData> a,
    TreeNodeSpec<DenpaMenNodeData> b,
  ) {
    final byId = _denpaMenById;
    final orderA = a.data.record.denpaMen.newCatchOrder(byId) ?? 0;
    final orderB = b.data.record.denpaMen.newCatchOrder(byId) ?? 0;
    return orderA.compareTo(orderB);
  }

  @override
  void initState() {
    super.initState();
    _controller.selectionMode.value = widget.selectionMode;
    _controller.selectedKeys.value = widget.selectedIds;
  }

  @override
  void didUpdateWidget(covariant DenpaMenLineageGraph oldWidget) {
    super.didUpdateWidget(oldWidget);
    _controller.refreshIfChanged(
      _groupsOf(widget.qrCodes),
      _nodesOf(widget.denpaMenRecords),
    );
    if (widget.selectionMode != oldWidget.selectionMode) {
      _controller.selectionMode.value = widget.selectionMode;
    }
    if (!const SetEquality<int>().equals(
      widget.selectedIds,
      oldWidget.selectedIds,
    )) {
      _controller.selectedKeys.value = widget.selectedIds;
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _handleHoveredChanged(Object? nodeKey, DenpaMenNodeData? data) {
    widget.onHoveredRecordChanged?.call(data?.record.id);
    _controller.hoveredKey.value = (data != null && data.isBred)
        ? data.record.denpaMen.id
        : null;
  }

  Future<void> _showQrCodeImage(BuildContext context, String rawValue) async {
    setState(() => _qrDialogOpen = true);
    await AppDialog.show<void>(
      context: context,
      builder: (context) => QrCodeImageDialog(rawValue: rawValue),
    );
    if (mounted) {
      setState(() => _qrDialogOpen = false);
    }
  }

  Widget _buildNode(
    BuildContext context,
    Object nodeKey,
    DenpaMenNodeData? data,
    QrCodeGroupData? groupData,
  ) {
    const nodeSize = 64.0;
    if (groupData != null) {
      if (_qrDialogOpen) {
        return const SizedBox(width: nodeSize, height: nodeSize);
      }
      return Builder(
        builder: (context) => GestureDetector(
          onTap: () => _showQrCodeImage(context, groupData.rawValue),
          child: QrCodeNode(rawValue: groupData.rawValue, size: nodeSize),
        ),
      );
    }
    if (data == null) {
      return const SizedBox(width: nodeSize, height: nodeSize);
    }
    return Builder(
      builder: (context) => DenpaMenTreeNode(
        key: ValueKey(nodeKey),
        data: data,
        icon:
            widget.iconBuilder?.call(data.record.denpaMen.id, nodeSize) ??
            staticDenpaMenIconBuilder(null)(nodeSize),
        nodeSize: nodeSize,
        hoveredKey: _controller.hoveredKey,
        dataByKey: _controller.graphData.nodeDataByKey,
        denpaMenById: _denpaMenById,
        incomingSourceKeysByKey: _controller.graphData.incomingSourceKeysByKey,
        graphNodeKey: nodeKey,
        selectionMode: _controller.selectionMode,
        selectedIds: _controller.selectedKeys,
        onToggleSelection: widget.onToggleSelection,
        onMiddleClick: widget.onMiddleClickSelect,
        onTap: () => widget.onTapNode(context, data.record.denpaMen),
        onHoverEnter: data.isBred && !widget.cursorEnabled
            ? () => _controller.hoveredKey.value = data.record.denpaMen.id
            : null,
        onHoverExit: data.isBred && !widget.cursorEnabled
            ? () => _controller.hoveredKey.value = null
            : null,
        contextMenuBuilder: widget.contextMenuBuilder,
        nodeKey: _controller.nodeEntriesByKey
            .putIfAbsent(nodeKey, () => (GlobalKey(), data))
            .$1,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return TreeGraphView<DenpaMenNodeData, QrCodeGroupData>(
      controller: _controller,
      nodeBuilder: _buildNode,
      graphViewController: widget.graphViewController,
      cursorEnabled: widget.cursorEnabled,
      visualRefreshToken: _qrDialogOpen,
      onHoveredChanged: widget.cursorEnabled ? _handleHoveredChanged : null,
      overlay: widget.cursorEnabled ? const TreeGraphCursorIcon() : null,
    );
  }
}
