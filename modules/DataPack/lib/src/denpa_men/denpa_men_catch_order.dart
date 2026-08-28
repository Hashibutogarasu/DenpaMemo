import 'dart:math';

import 'denpa_men.dart';

/// Replaces the deprecated [DenpaMen.catchOrder] as the source of truth
/// for display and sorting.
extension DenpaMenCatchOrderResolution on DenpaMen {
  /// Resolves the most recently caught ancestor's catch order, walking
  /// every [DenpaMen.parentIds] entry via [byId] and taking the largest
  /// resolved value. Null if unresolvable through any parent.
  int? newCatchOrder(Map<String, DenpaMen> byId, [Set<String>? visited]) {
    if (parentIds.isEmpty) {
      // ignore: deprecated_member_use_from_same_package
      return catchOrder;
    }
    final seen = visited ?? <String>{};
    if (!seen.add(id)) {
      return null;
    }
    final resolvedOrders = parentIds
        .map((parentId) => byId[parentId]?.newCatchOrder(byId, seen))
        .whereType<int>();
    return resolvedOrders.isEmpty ? null : resolvedOrders.reduce(max);
  }
}
