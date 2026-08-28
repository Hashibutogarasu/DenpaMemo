import 'package:collection/collection.dart';
import 'package:flutter/widgets.dart';
import 'package:graphview/GraphView.dart' show SugiyamaConfiguration;

import 'tree_graph_data.dart';
import 'tree_node_spec.dart';

/// Owns a `TreeGraphView`'s graph/selection/hover state, independent of
/// the widget tree. [snapshotOf] extracts the parts of [groups]/[nodes]
/// that affect structure, so [refreshIfChanged] can tell whether a
/// rebuild is needed without comparing [T]/[G] directly.
class TreeGraphController<T, G> {
  TreeGraphController({
    required List<TreeGroupSpec<G>> groups,
    required List<TreeNodeSpec<T>> nodes,
    required this.snapshotOf,
    this.siblingOrder,
    this.layoutConfiguration,
  }) : _dataSnapshotValue = snapshotOf(groups, nodes),
       graphData = buildForestGraph(
         groups: groups,
         nodes: nodes,
         siblingOrder: siblingOrder,
         layoutConfiguration: layoutConfiguration,
       );

  final List<Object?> Function(
    List<TreeGroupSpec<G>> groups,
    List<TreeNodeSpec<T>> nodes,
  )
  snapshotOf;
  final int Function(TreeNodeSpec<T> a, TreeNodeSpec<T> b)? siblingOrder;
  final SugiyamaConfiguration? layoutConfiguration;

  List<Object?> _dataSnapshotValue;
  TreeGraphData<T, G> graphData;
  int generation = 0;

  final hoveredKey = ValueNotifier<Object?>(null);
  final selectionMode = ValueNotifier<bool>(false);
  final selectedKeys = ValueNotifier<Set<Object>>({});
  final nodeEntriesByKey = <Object, (GlobalKey, T?)>{};

  bool refreshIfChanged(List<TreeGroupSpec<G>> groups, List<TreeNodeSpec<T>> nodes) {
    final newSnapshot = snapshotOf(groups, nodes);
    if (const DeepCollectionEquality().equals(newSnapshot, _dataSnapshotValue)) {
      return false;
    }
    _dataSnapshotValue = newSnapshot;
    forceRefresh(groups, nodes);
    return true;
  }

  void forceRefresh(List<TreeGroupSpec<G>> groups, List<TreeNodeSpec<T>> nodes) {
    generation++;
    nodeEntriesByKey.clear();
    graphData = buildForestGraph(
      groups: groups,
      nodes: nodes,
      siblingOrder: siblingOrder,
      layoutConfiguration: layoutConfiguration,
    );
  }

  void dispose() {
    hoveredKey.dispose();
    selectionMode.dispose();
    selectedKeys.dispose();
  }
}
