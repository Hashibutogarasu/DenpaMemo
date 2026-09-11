import 'dart:math';

import 'denpa_men.dart';

/// Derives the [DenpaMen.catchOrder] value for a bred individual from its
/// lineage. Callers persist the result instead of resolving it on every read.
extension DenpaMenCatchOrderResolution on DenpaMen {
  /// Resolves the most recently caught ancestor's catch order, walking every
  /// [DenpaMen.parentIds] entry via [byId] and taking the largest resolved
  /// value. Null if unresolvable through any parent.
  int? resolveCatchOrder(Map<String, DenpaMen> byId, [Set<String>? visited]) {
    if (parentIds.isEmpty) {
      return catchOrder;
    }
    final seen = visited ?? <String>{};
    if (!seen.add(id)) {
      return null;
    }
    final resolvedOrders = parentIds
        .map((parentId) => byId[parentId]?.resolveCatchOrder(byId, seen))
        .whereType<int>();
    return resolvedOrders.isEmpty ? null : resolvedOrders.reduce(max);
  }
}
