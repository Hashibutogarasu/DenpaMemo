import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:graphview/GraphView.dart';

import '../../domain/denpa_men/denpa_men.dart';
import '../../domain/denpa_men/denpa_men_record.dart';
import '../../domain/master_data/master_data.dart';
import '../../domain/qr_code/qr_code_record.dart';
import '../dialog/denpa_men_action_menu.dart';
import '../dialog/denpa_men_preview_dialog.dart';
import '../dialog/qr_code_image_dialog.dart';
import 'center_first.dart';
import 'denpa_men_node.dart';
import 'lineage_edge_renderer.dart';
import 'lineage_graph_data_snapshot.dart';
import 'node_info.dart';
import 'qr_code_node.dart';

class LineageGraph extends ConsumerStatefulWidget {
  const LineageGraph({
    super.key,
    required this.qrCodes,
    required this.denpaMenRecords,
    required this.masterData,
    required this.iconsById,
    this.controller,
  });

  final List<QrCodeRecord> qrCodes;
  final List<DenpaMenRecord> denpaMenRecords;
  final MasterData masterData;
  final Map<String, File?> iconsById;
  final GraphViewController? controller;

  @override
  ConsumerState<LineageGraph> createState() => _LineageGraphState();
}

class _LineageGraphState extends ConsumerState<LineageGraph> {
  bool _qrDialogOpen = false;
  int _generation = 0;
  late List<Object?> _dataSnapshotValue;

  @override
  void initState() {
    super.initState();
    _dataSnapshotValue = lineageDataSnapshot(
      widget.qrCodes,
      widget.denpaMenRecords,
    );
  }

  @override
  void didUpdateWidget(covariant LineageGraph oldWidget) {
    super.didUpdateWidget(oldWidget);
    final newSnapshot = lineageDataSnapshot(
      widget.qrCodes,
      widget.denpaMenRecords,
    );
    if (!lineageDataSnapshotsEqual(newSnapshot, _dataSnapshotValue)) {
      _dataSnapshotValue = newSnapshot;
      _generation++;
    }
  }

  void _showPreview(BuildContext context, DenpaMen denpaMen) {
    DenpaMenPreviewDialog.show(context, denpaMen: denpaMen);
  }

  Future<void> _showQrCodeImage(BuildContext context, String rawValue) async {
    setState(() => _qrDialogOpen = true);
    await showDialog<void>(
      context: context,
      builder: (context) => QrCodeImageDialog(rawValue: rawValue),
    );
    if (mounted) {
      setState(() => _qrDialogOpen = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    const nodeSize = 64.0;
    const superRootKey = 'superRoot';

    final graph = Graph();
    final nodeInfoByKey = <Object, NodeInfo>{};
    final addedIds = <String>{};

    final superRootNode = Node.Id(superRootKey);
    graph.addNode(superRootNode);
    nodeInfoByKey[superRootKey] = const NodeInfo(kind: NodeKind.invisible);

    for (final qrCodeRecord in widget.qrCodes) {
      final qrCode = qrCodeRecord.qrCode;
      final rootKey = 'qr:${qrCode.id}';
      graph.addEdge(
        superRootNode,
        Node.Id(rootKey),
        paint: Paint()..color = Colors.transparent,
      );
      nodeInfoByKey[rootKey] = NodeInfo(
        kind: NodeKind.qrCode,
        rawValue: qrCode.rawValue,
      );

      final directChildren =
          widget.denpaMenRecords
              .where((record) => record.denpaMen.qrCodeId == qrCode.id)
              .toList()
            ..sort(
              (a, b) => (a.denpaMen.catchOrder ?? 0).compareTo(
                b.denpaMen.catchOrder ?? 0,
              ),
            );

      for (final record in centerFirst(directChildren)) {
        final id = record.denpaMen.id;
        if (!addedIds.add(id)) {
          continue;
        }
        nodeInfoByKey[id] = NodeInfo(
          kind: NodeKind.caughtDenpaMen,
          name: record.denpaMen.name,
          catchIndex: (record.denpaMen.catchOrder ?? 0) + 1,
          record: record,
        );
        graph.addEdge(Node.Id(rootKey), Node.Id(id));
      }
    }

    var progress = true;
    while (progress) {
      progress = false;
      for (final record in widget.denpaMenRecords) {
        final id = record.denpaMen.id;
        final parentIds = record.denpaMen.parentIds;
        if (addedIds.contains(id) || parentIds.isEmpty) {
          continue;
        }
        if (!parentIds.every(addedIds.contains)) {
          continue;
        }
        nodeInfoByKey[id] = NodeInfo(
          kind: NodeKind.bredDenpaMen,
          name: record.denpaMen.name,
          record: record,
        );
        for (final parentId in parentIds) {
          graph.addEdge(Node.Id(parentId), Node.Id(id));
        }
        addedIds.add(id);
        progress = true;
      }
    }

    final config = SugiyamaConfiguration()
      ..nodeSeparation = 32
      ..levelSeparation = 48
      ..orientation = SugiyamaConfiguration.ORIENTATION_TOP_BOTTOM;
    final edgeRendererConfig = BuchheimWalkerConfiguration()
      ..orientation = BuchheimWalkerConfiguration.ORIENTATION_TOP_BOTTOM;
    final algorithm = SugiyamaAlgorithm(config)
      ..renderer = LineageEdgeRenderer(edgeRendererConfig);

    return GraphView.builder(
      key: ValueKey(_generation),
      graph: graph,
      algorithm: algorithm,
      controller: widget.controller,
      autoZoomToFit: true,
      centerGraph: true,
      builder: (node) {
        final info = nodeInfoByKey[node.key!.value];
        return RepaintBoundary(
          child: switch (info?.kind) {
            NodeKind.qrCode => _qrDialogOpen
                ? SizedBox(width: nodeSize, height: nodeSize)
                : GestureDetector(
                    onTap: () => _showQrCodeImage(context, info.rawValue!),
                    child: QrCodeNode(
                      rawValue: info!.rawValue!,
                      size: nodeSize,
                    ),
                  ),
            NodeKind.caughtDenpaMen => DenpaMenContextMenuArea(
              record: info!.record!,
              masterData: widget.masterData,
              child: GestureDetector(
                onTap: () => _showPreview(context, info.record!.denpaMen),
                child: DenpaMenNode(
                  iconFile: widget.iconsById[info.record!.denpaMen.id],
                  name: info.name!,
                  catchIndex: info.catchIndex,
                  size: nodeSize,
                ),
              ),
            ),
            NodeKind.bredDenpaMen => DenpaMenContextMenuArea(
              record: info!.record!,
              masterData: widget.masterData,
              child: GestureDetector(
                onTap: () => _showPreview(context, info.record!.denpaMen),
                child: DenpaMenNode(
                  iconFile: widget.iconsById[info.record!.denpaMen.id],
                  name: info.name!,
                  size: nodeSize,
                ),
              ),
            ),
            NodeKind.invisible || null => SizedBox(
              width: nodeSize,
              height: nodeSize,
            ),
          },
        );
      },
    );
  }
}
