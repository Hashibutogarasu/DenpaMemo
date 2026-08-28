import 'package:flutter/material.dart';
import 'package:tree_graph/tree_graph.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

@widgetbook.UseCase(name: 'Default', type: NodeBadge, path: 'lineage')
Widget nodeBadgeUseCase(BuildContext context) {
  final text = context.knobs.string(label: 'バッジ', initialValue: '3');

  return NodeBadge(value: int.tryParse(text) ?? 0);
}
