import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:graphview/GraphView.dart';

import 'package:denpa_memo/widgets/lineage/lineage_edge_renderer.dart';

/// Pumps a 2-node top-bottom tree (parent above child, both 64x64) through
/// a real [GraphView] layout pass using [edgeRenderer], then returns the
/// resulting [parent], [child] (with their post-layout `position`/`size`
/// populated by the algorithm) and the [renderer]'s own `linePath` bounds
/// for the edge between them.
Future<({Node parent, Node child, Rect pathBounds})> _layoutAndRenderEdge(
  WidgetTester tester,
  TreeEdgeRenderer edgeRenderer,
) async {
  final graph = Graph()..isTree = true;
  final parent = Node.Id('parent');
  final child = Node.Id('child');
  graph.addEdge(parent, child);

  final config = BuchheimWalkerConfiguration()
    ..orientation = BuchheimWalkerConfiguration.ORIENTATION_TOP_BOTTOM;

  await tester.pumpWidget(
    MaterialApp(
      home: Scaffold(
        body: SizedBox(
          width: 400,
          height: 400,
          child: GraphView.builder(
            graph: graph,
            algorithm: BuchheimWalkerAlgorithm(config, edgeRenderer),
            animated: false,
            builder: (node) => const SizedBox(width: 64, height: 64),
          ),
        ),
      ),
    ),
  );
  await tester.pump();

  edgeRenderer.linePath.reset();
  edgeRenderer.buildEdgePath(
    parent,
    child,
    parent.position,
    child.position,
    BuchheimWalkerConfiguration.ORIENTATION_TOP_BOTTOM,
  );

  return (parent: parent, child: child, pathBounds: edgeRenderer.linePath.getBounds());
}

void main() {
  testWidgets(
    'reproduces the upstream bug: stock TreeEdgeRenderer draws the edge '
    'through both node centers instead of their facing borders',
    (tester) async {
      final config = BuchheimWalkerConfiguration()
        ..orientation = BuchheimWalkerConfiguration.ORIENTATION_TOP_BOTTOM;
      final result = await _layoutAndRenderEdge(
        tester,
        TreeEdgeRenderer(config),
      );

      final parentBottom = result.parent.position.dy + result.parent.height;
      final childTop = result.child.position.dy;

      // The bug: the path starts at the parent's center (above its true
      // bottom edge) and ends at the child's center (below its true top
      // edge), so it visibly cuts through both node squares.
      expect(result.pathBounds.top, lessThan(parentBottom));
      expect(result.pathBounds.bottom, greaterThan(childTop));
    },
  );

  testWidgets(
    'LineageEdgeRenderer stops the edge exactly at each node\'s border',
    (tester) async {
      final config = BuchheimWalkerConfiguration()
        ..orientation = BuchheimWalkerConfiguration.ORIENTATION_TOP_BOTTOM;
      final result = await _layoutAndRenderEdge(
        tester,
        LineageEdgeRenderer(config),
      );

      final parentBottom = result.parent.position.dy + result.parent.height;
      final childTop = result.child.position.dy;

      expect(result.pathBounds.top, closeTo(parentBottom, 0.5));
      expect(result.pathBounds.bottom, closeTo(childTop, 0.5));
    },
  );
}
