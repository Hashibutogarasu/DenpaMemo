import 'package:flutter/material.dart';

import '../../domain/denpa_men/denpa_men.dart';
import '../../domain/denpa_men/denpa_men_catch_order.dart';
import '../color/body_color_palette.dart';

/// Whether [nodeDenpaMenId] is a parent of whichever bred individual
/// [hoveredBredId] names, per [denpaMenById].
bool isLineageNodeHighlighted(
  String nodeDenpaMenId,
  String? hoveredBredId,
  Map<String, DenpaMen> denpaMenById,
) {
  if (hoveredBredId == null) {
    return false;
  }
  return denpaMenById[hoveredBredId]?.parentIds.contains(nodeDenpaMenId) ??
      false;
}

/// [denpaMen]'s body color, for the highlight border drawn around a
/// hovered bred individual's parents.
Color? lineageNodeHighlightColor(DenpaMen denpaMen) {
  if (denpaMen.bodyColors.isEmpty) {
    return null;
  }
  return bodyColorPalette[denpaMen.bodyColors.first];
}

/// The catch-order badge shown on a hovered bred individual's parent,
/// resolved via [DenpaMenCatchOrderResolution.newCatchOrder].
int? lineageNodeBadgeValue(DenpaMen denpaMen, Map<String, DenpaMen> byId) {
  final resolved = denpaMen.newCatchOrder(byId);
  return resolved == null ? null : resolved + 1;
}
