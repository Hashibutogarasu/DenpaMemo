import 'package:data_pack/data_pack.dart';
import 'package:flutter/material.dart';
import 'package:tree_graph/tree_graph.dart';

import '../color/body_color_palette.dart';
import 'denpa_men_node_data.dart';

/// Ranks a target parent among the hovered child's own parents by
/// [DenpaMenCatchOrderResolution.newCatchOrder], so the badge stays free
/// of collisions with parents caught under a different QR code.
class DenpaMenHighlightStrategy implements TreeNodeHighlightStrategy<DenpaMenNodeData> {
  const DenpaMenHighlightStrategy({required this.denpaMenById});

  final Map<String, DenpaMen> denpaMenById;

  @override
  Color? highlightColor(DenpaMenNodeData data) {
    final denpaMen = data.record.denpaMen;
    if (denpaMen.bodyColors.isEmpty) {
      return null;
    }
    return bodyColorPalette[denpaMen.bodyColors.first];
  }

  @override
  String? badgeText(DenpaMenNodeData data, DenpaMenNodeData hoveredData) {
    final hoveredChild = hoveredData.record.denpaMen;
    final sortedParentIds = hoveredChild.parentIds.toList()
      ..sort((a, b) {
        final orderA = denpaMenById[a]?.newCatchOrder(denpaMenById) ?? 0;
        final orderB = denpaMenById[b]?.newCatchOrder(denpaMenById) ?? 0;
        return orderA.compareTo(orderB);
      });
    final rank = sortedParentIds.indexOf(data.record.denpaMen.id);
    return rank == -1 ? null : '${rank + 1}';
  }
}
