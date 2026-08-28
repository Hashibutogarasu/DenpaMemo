import 'package:flutter/material.dart';
import 'package:tree_graph/tree_graph.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

@widgetbook.UseCase(name: 'Default', type: NodeBadgeBackground, path: 'lineage')
Widget nodeBadgeBackgroundUseCase(BuildContext context) {
  return const NodeBadgeBackground(child: Icon(Icons.star, size: 12));
}
