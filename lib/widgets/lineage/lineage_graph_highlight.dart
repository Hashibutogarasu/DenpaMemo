import 'package:data_pack/data_pack.dart';
import 'package:denpamemo_widgets/denpamemo_widgets.dart' hide BuildContextTranslationsExtension;
import 'package:flutter/material.dart';


/// Whether [nodeKey] is one of the actual parent graph nodes feeding into
/// whichever bred individual [hoveredBredId] names, per
/// [incomingSourceKeysById]. Matching by graph node key (rather than by
/// [DenpaMen.id]) is required so that, when a parent is reused by several
/// children and duplicated into multiple graph nodes (see
/// `duplicateParentNodeKeyFor` in lineage_graph_builder.dart), hovering one
/// child highlights only its own copy of that parent.
bool isLineageNodeHighlighted(
  Object nodeKey,
  String? hoveredBredId,
  Map<String, List<Object>> incomingSourceKeysById,
) {
  if (hoveredBredId == null) {
    return false;
  }
  return incomingSourceKeysById[hoveredBredId]?.contains(nodeKey) ?? false;
}

/// [denpaMen]'s body color, for the highlight border drawn around a
/// hovered bred individual's parents.
Color? lineageNodeHighlightColor(DenpaMen denpaMen) {
  if (denpaMen.bodyColors.isEmpty) {
    return null;
  }
  return bodyColorPalette[denpaMen.bodyColors.first];
}

/// The catch-order badge shown on one of [hoveredBredId]'s parents,
/// identified by [denpaMenId]: this parent's rank (1-indexed) among
/// [hoveredBredId]'s own [DenpaMen.parentIds] when sorted by
/// [DenpaMenCatchOrderResolution.newCatchOrder]. Ranking within just this
/// one breeding pair — rather than showing each parent's raw resolved
/// catch order — keeps the badge small and free of collisions between
/// parents caught under different QR codes, whose raw catch orders are
/// otherwise unrelated numbers.
int? lineageNodeParentBadgeValue(
  String denpaMenId,
  String hoveredBredId,
  Map<String, DenpaMen> byId,
) {
  final hoveredChild = byId[hoveredBredId];
  if (hoveredChild == null) {
    return null;
  }
  final sortedParentIds = hoveredChild.parentIds.toList()
    ..sort((a, b) {
      final orderA = byId[a]?.newCatchOrder(byId) ?? 0;
      final orderB = byId[b]?.newCatchOrder(byId) ?? 0;
      return orderA.compareTo(orderB);
    });
  final rank = sortedParentIds.indexOf(denpaMenId);
  return rank == -1 ? null : rank + 1;
}
