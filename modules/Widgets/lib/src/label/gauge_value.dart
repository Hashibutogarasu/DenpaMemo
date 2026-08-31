/// A value paired with its cap — level/maxLevel, happiness/maxHappiness,
/// or anything else that can be "maxed out" — so display widgets can share
/// one "current/max" formatting and maxed-out styling rule instead of each
/// reimplementing it.
class GaugeValue {
  const GaugeValue({required this.current, required this.max});

  final int current;
  final int max;

  bool get isMaxed => current >= max;
}
