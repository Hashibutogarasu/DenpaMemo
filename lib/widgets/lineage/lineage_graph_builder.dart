import 'package:data_pack/data_pack.dart';
import 'package:flutter/material.dart';
import 'package:graphview/GraphView.dart';

import 'lineage_edge_renderer.dart';
import 'node_info.dart';

/// The [Graph]/[Algorithm] GraphView lays out, plus the [NodeInfo] and
/// [DenpaMen] lookups [LineageGraph](lineage_graph.dart) needs to render
/// and highlight each node.
class LineageGraphData {
  const LineageGraphData({
    required this.graph,
    required this.algorithm,
    required this.nodeInfoByKey,
    required this.denpaMenById,
    required this.incomingSourceKeysById,
  });

  final Graph graph;
  final Algorithm algorithm;
  final Map<Object, NodeInfo> nodeInfoByKey;
  final Map<String, DenpaMen> denpaMenById;

  /// For each [DenpaMen.id], the graph node key(s) — including any
  /// [duplicateParentNodeKeyFor] duplicates — that feed into it as parents.
  final Map<String, List<Object>> incomingSourceKeysById;
}

/// Builds the QR-code roots, their directly caught individuals (in catch
/// order), and every bred descendant reached by following
/// `DenpaMen.parentIds`. A parent used by more than one bred individual is
/// duplicated into its own node per extra child — see
/// [duplicateParentNodeKeyFor] — so no single node ends up shared by
/// children with different catch-order lineages.
LineageGraphData buildLineageGraphData({
  required List<QrCodeRecord> qrCodes,
  required List<DenpaMenRecord> denpaMenRecords,
}) {
  const superRootKey = 'superRoot';

  final graph = Graph();
  final nodeInfoByKey = <Object, NodeInfo>{};
  final addedIds = <String>{};
  final incomingSourceKeysById = <String, List<Object>>{};
  final denpaMenById = {
    for (final record in denpaMenRecords) record.denpaMen.id: record.denpaMen,
  };

  final superRootNode = Node.Id(superRootKey);
  graph.addNode(superRootNode);
  nodeInfoByKey[superRootKey] = const NodeInfo(kind: NodeKind.invisible);

  for (final qrCodeRecord in qrCodes) {
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
        denpaMenRecords
            .where((record) => record.denpaMen.qrCodeId == qrCode.id)
            .toList()
          ..sort(
            (a, b) => (a.denpaMen.newCatchOrder(denpaMenById) ?? 0).compareTo(
              b.denpaMen.newCatchOrder(denpaMenById) ?? 0,
            ),
          );

    for (final record in directChildren) {
      final id = record.denpaMen.id;
      if (!addedIds.add(id)) {
        continue;
      }
      nodeInfoByKey[id] = NodeInfo(
        kind: NodeKind.caughtDenpaMen,
        name: record.denpaMen.name,
        record: record,
      );
      incomingSourceKeysById[id] = [rootKey];
      graph.addEdge(Node.Id(rootKey), Node.Id(id));
    }
  }

  final parentNodeUsageCountById = <String, int>{};
  var progress = true;
  while (progress) {
    progress = false;
    for (final record in denpaMenRecords) {
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
      final myIncomingSourceKeys = <Object>[];
      for (final parentId in parentIds) {
        final parentNodeKey = duplicateParentNodeKeyFor(
          parentId,
          parentNodeUsageCountById,
        );
        if (parentNodeKey != parentId) {
          nodeInfoByKey[parentNodeKey] = nodeInfoByKey[parentId]!;
          for (final sourceKey in incomingSourceKeysById[parentId]!) {
            graph.addEdge(Node.Id(sourceKey), Node.Id(parentNodeKey));
          }
        }
        graph.addEdge(Node.Id(parentNodeKey), Node.Id(id));
        myIncomingSourceKeys.add(parentNodeKey);
      }
      incomingSourceKeysById[id] = myIncomingSourceKeys;
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

  return LineageGraphData(
    graph: graph,
    algorithm: algorithm,
    nodeInfoByKey: nodeInfoByKey,
    denpaMenById: denpaMenById,
    incomingSourceKeysById: incomingSourceKeysById,
  );
}

/// The first child to reference [parentId] gets the parent's own node key
/// back unchanged; every later child gets a distinct duplicate key
/// (`(parentId, occurrence)`), so each child's catch-order lineage
/// highlights its own copy of the parent instead of fighting over one
/// shared node. [usageCountById] tracks how many times each parent id has
/// been claimed so far and is mutated in place.
Object duplicateParentNodeKeyFor(
  String parentId,
  Map<String, int> usageCountById,
) {
  final usageIndex = usageCountById.update(
    parentId,
    (count) => count + 1,
    ifAbsent: () => 0,
  );
  return usageIndex == 0 ? parentId : (parentId, usageIndex);
}
