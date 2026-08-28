import 'package:flutter/material.dart';
import 'package:graphview/GraphView.dart';
import 'package:tree_graph/tree_graph.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

@widgetbook.UseCase(name: 'Default', type: TreeEdgeRendererFix, path: 'lineage')
Widget treeEdgeRendererFixUseCase(BuildContext context) {
  final graph = Graph()..isTree = true;
  graph.addEdge(Node.Id('parent'), Node.Id('child'));

  final config = BuchheimWalkerConfiguration()
    ..orientation = BuchheimWalkerConfiguration.ORIENTATION_TOP_BOTTOM;

  return SizedBox.expand(
    child: GraphView.builder(
      graph: graph,
      algorithm: BuchheimWalkerAlgorithm(config, TreeEdgeRendererFix(config)),
      animated: false,
      builder: (node) => Container(
        width: 64,
        height: 64,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Text('${node.key?.value}'),
      ),
    ),
  );
}
