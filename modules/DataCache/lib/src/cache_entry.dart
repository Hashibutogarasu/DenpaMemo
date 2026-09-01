/// A cached input/output pair, kept as independent components rather than
/// a single merged value. [I]/[O] are whatever domain types the caller
/// works with; JSON is purely an internal storage detail of
/// [CacheIndexRepository] and never crosses this type's public surface.
class CacheEntry<I, O> {
  const CacheEntry({required this.input, required this.output});

  final I input;
  final O output;
}
