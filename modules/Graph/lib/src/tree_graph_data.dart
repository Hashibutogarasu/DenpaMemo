import 'package:flutter/material.dart';
import 'package:graphview/GraphView.dart';

import 'tree_edge_renderer_fix.dart';
import 'tree_node_spec.dart';

/// The laid-out [Graph]/[Algorithm], plus per-key lookups for rendering
/// and highlighting.
class TreeGraphData<T, G> {
  const TreeGraphData({
    required this.graph,
    required this.algorithm,
    required this.nodeDataByKey,
    required this.groupDataByKey,
    required this.incomingSourceKeysByKey,
  });

  final Graph graph;
  final Algorithm algorithm;
  final Map<Object, T> nodeDataByKey;
  final Map<Object, G> groupDataByKey;

  /// Per spec key, the graph node key(s) (including [duplicateKeyFor]
  /// duplicates) that feed into it as parents.
  final Map<Object, List<Object>> incomingSourceKeysByKey;
}

/// Builds [groups]' roots, their direct children (matched by `groupKey`,
/// ordered by [siblingOrder]), and every descendant reached via
/// [TreeNodeSpec.parentKeys]. A parent shared by multiple children is
/// duplicated per extra child — see [duplicateKeyFor].
TreeGraphData<T, G> buildForestGraph<T, G>({
  required List<TreeGroupSpec<G>> groups,
  required List<TreeNodeSpec<T>> nodes,
  int Function(TreeNodeSpec<T> a, TreeNodeSpec<T> b)? siblingOrder,
  SugiyamaConfiguration? layoutConfiguration,
}) {
  const superRootKey = 'superRoot';

  final graph = Graph();
  final nodeDataByKey = <Object, T>{};
  final groupDataByKey = <Object, G>{for (final g in groups) g.key: g.data};
  final nodeSpecByKey = {for (final n in nodes) n.key: n};
  final addedKeys = <Object>{};
  final incomingSourceKeysByKey = <Object, List<Object>>{};

  final superRootNode = Node.Id(superRootKey);
  graph.addNode(superRootNode);

  for (final group in groups) {
    graph.addEdge(
      superRootNode,
      Node.Id(group.key),
      paint: Paint()..color = Colors.transparent,
    );

    final directChildren = nodes.where((n) => n.groupKey == group.key).toList();
    if (siblingOrder != null) {
      directChildren.sort(siblingOrder);
    }

    for (final node in directChildren) {
      if (!addedKeys.add(node.key)) {
        continue;
      }
      nodeDataByKey[node.key] = node.data;
      incomingSourceKeysByKey[node.key] = [group.key];
      graph.addEdge(Node.Id(group.key), Node.Id(node.key));
    }
  }

  final parentNodeUsageCountByKey = <Object, int>{};
  var progress = true;
  while (progress) {
    progress = false;
    for (final node in nodes) {
      final key = node.key;
      final parentKeys = node.parentKeys;
      if (addedKeys.contains(key) || parentKeys.isEmpty) {
        continue;
      }
      if (!parentKeys.every(addedKeys.contains)) {
        continue;
      }
      nodeDataByKey[key] = node.data;
      final myIncomingSourceKeys = <Object>[];
      for (final parentKey in parentKeys) {
        final duplicatedParentKey = duplicateKeyFor(
          parentKey,
          parentNodeUsageCountByKey,
        );
        if (duplicatedParentKey != parentKey) {
          nodeDataByKey[duplicatedParentKey] = nodeSpecByKey[parentKey]!.data;
          for (final sourceKey in incomingSourceKeysByKey[parentKey]!) {
            graph.addEdge(Node.Id(sourceKey), Node.Id(duplicatedParentKey));
          }
        }
        graph.addEdge(Node.Id(duplicatedParentKey), Node.Id(key));
        myIncomingSourceKeys.add(duplicatedParentKey);
      }
      incomingSourceKeysByKey[key] = myIncomingSourceKeys;
      addedKeys.add(key);
      progress = true;
    }
  }

  final config =
      layoutConfiguration ??
      (SugiyamaConfiguration()
        ..nodeSeparation = 32
        ..levelSeparation = 48
        ..orientation = SugiyamaConfiguration.ORIENTATION_TOP_BOTTOM);
  final edgeRendererConfig = BuchheimWalkerConfiguration()
    ..orientation = BuchheimWalkerConfiguration.ORIENTATION_TOP_BOTTOM;
  final algorithm = SugiyamaAlgorithm(config)
    ..renderer = TreeEdgeRendererFix(edgeRendererConfig);

  return TreeGraphData(
    graph: graph,
    algorithm: algorithm,
    nodeDataByKey: nodeDataByKey,
    groupDataByKey: groupDataByKey,
    incomingSourceKeysByKey: incomingSourceKeysByKey,
  );
}

/// The first reference to [key] gets it back unchanged; every later one
/// gets a distinct `(key, occurrence)` duplicate. [usageCountByKey] is
/// mutated in place.
Object duplicateKeyFor(Object key, Map<Object, int> usageCountByKey) {
  final usageIndex = usageCountByKey.update(
    key,
    (count) => count + 1,
    ifAbsent: () => 0,
  );
  return usageIndex == 0 ? key : (key, usageIndex);
}
