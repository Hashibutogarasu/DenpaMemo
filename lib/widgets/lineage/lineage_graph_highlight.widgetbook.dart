import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

import '../../widgetbook/denpa_men/route_denpa_men_data.dart';
import 'lineage_graph_highlight.dart';

@widgetbook.UseCase(name: 'Default', type: Color, path: 'lineage')
Widget lineageGraphHighlightUseCase(BuildContext context) {
  final child = RouteDenpaMenData.all.firstWhere((d) => d.parentIds.isNotEmpty);
  final parentId = child.parentIds.first;
  final parent = RouteDenpaMenData.byId[parentId]!;
  final highlighted = context.knobs.boolean(label: 'ハイライト', initialValue: true);
  final hoveredBredId = highlighted ? child.id : null;

  final isHighlighted = isLineageNodeHighlighted(parentId, hoveredBredId, {
    child.id: [parentId],
  });
  final color = lineageNodeHighlightColor(parent);
  final badge = hoveredBredId == null
      ? null
      : lineageNodeParentBadgeValue(parentId, hoveredBredId, {
          child.id: child,
          parentId: parent,
        });

  return Padding(
    padding: const EdgeInsets.all(16),
    child: Text(
      'isLineageNodeHighlighted: $isHighlighted\n'
      'lineageNodeHighlightColor: $color\n'
      'lineageNodeParentBadgeValue: $badge',
    ),
  );
}
