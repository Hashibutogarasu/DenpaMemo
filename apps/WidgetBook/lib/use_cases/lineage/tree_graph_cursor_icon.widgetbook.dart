import 'package:flutter/material.dart';
import 'package:tree_graph/tree_graph.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

@widgetbook.UseCase(name: 'Default', type: TreeGraphCursorIcon, path: 'lineage')
Widget treeGraphCursorIconUseCase(BuildContext context) {
  return const TreeGraphCursorIcon();
}
