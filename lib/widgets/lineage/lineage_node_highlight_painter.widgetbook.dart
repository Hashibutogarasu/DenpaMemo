import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

import '../../widgetbook/denpa_men/route_denpa_men_data.dart';
import 'lineage_node_highlight_painter.dart';

Color? _parseRgb(String text) {
  final hex = text.replaceAll('#', '').trim();
  final value = int.tryParse(hex, radix: 16);
  if (value == null || hex.length != 6) {
    return null;
  }
  return Color(0xFF000000 | value);
}

@widgetbook.UseCase(
  name: 'Default',
  type: LineageNodeHighlightPainter,
  path: 'lineage',
)
Widget lineageNodeHighlightPainterUseCase(BuildContext context) {
  final highlighted = context.knobs.boolean(label: 'ハイライト', initialValue: true);
  final colorText = context.knobs.string(label: 'ハイライト色 (RRGGBB)', initialValue: 'FF0000');
  final badgeText = context.knobs.string(label: 'バッジ', initialValue: '1');
  final child = RouteDenpaMenData.all.firstWhere((d) => d.parentIds.isNotEmpty);
  final parentId = child.parentIds.first;

  return SizedBox(
    width: 80,
    height: 80,
    child: CustomPaint(
      painter: LineageNodeHighlightPainter(
        nodeKey: parentId,
        denpaMenId: parentId,
        denpaMenById: RouteDenpaMenData.byId,
        incomingSourceKeysById: {
          child.id: [parentId],
        },
        hoveredBredId: ValueNotifier<String?>(highlighted ? child.id : null),
        highlightColorOverride: _parseRgb(colorText),
        badgeTextOverride: badgeText.isEmpty ? null : badgeText,
      ),
    ),
  );
}
