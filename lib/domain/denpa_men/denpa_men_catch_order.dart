import 'denpa_men.dart';

/// Replaces the deprecated [DenpaMen.catchOrder] as the source of truth
/// for display and sorting.
extension DenpaMenCatchOrderResolution on DenpaMen {
  /// Resolves the earliest caught ancestor's catch order, walking
  /// [DenpaMen.parentIds] last via [byId]. Null if unresolvable.
  int? newCatchOrder(Map<String, DenpaMen> byId, [Set<String>? visited]) {
    if (parentIds.isEmpty) {
      // ignore: deprecated_member_use_from_same_package
      return catchOrder;
    }
    final seen = visited ?? <String>{};
    if (!seen.add(id)) {
      return null;
    }
    final lastParent = byId[parentIds.last];
    return lastParent?.newCatchOrder(byId, seen);
  }
}
