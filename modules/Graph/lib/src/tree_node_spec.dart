/// One node to lay out in a `TreeGraphView`. [key] is unique among all
/// nodes; [data] is opaque payload the graph never inspects. A node with
/// [groupKey] set is a direct child of that [TreeGroupSpec]; a node with
/// [parentKeys] set is reached by following those keys instead.
class TreeNodeSpec<T> {
  const TreeNodeSpec({
    required this.key,
    required this.data,
    this.parentKeys = const [],
    this.groupKey,
  });

  final Object key;
  final T data;
  final List<Object> parentKeys;
  final Object? groupKey;
}

/// One independent tree's root, e.g. the QR code a set of caught
/// individuals came from.
class TreeGroupSpec<G> {
  const TreeGroupSpec({required this.key, required this.data});

  final Object key;
  final G data;
}
