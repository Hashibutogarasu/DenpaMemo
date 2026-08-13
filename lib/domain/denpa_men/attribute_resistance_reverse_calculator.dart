import '../master_data/master_data.dart';
import 'attribute_resistance.dart';
import 'attribute_resistance_calculator.dart';

/// Searches [masterData] for a single body color (with or without SP), a
/// pair of distinct colors, or a same-color pair whose calculated
/// attribute resistance matches this list exactly.
///
/// Returns the first matching `(bodyColors, isSpColor)` combination found,
/// or null if none of the solo, distinct-pair, or same-pair candidates
/// produce that result.
extension AttributeResistanceReverseLookup on List<AttributeResistance> {
  BodyColorSelection? findColorCombination(MasterData masterData) {
    final target = _toMap(this);
    final colorIds = masterData.bodyColorResistanceRules
        .map((rule) => rule.colorId)
        .toList();

    final candidates = <BodyColorSelection>[
      for (final colorId in colorIds) (bodyColors: [colorId], isSpColor: false),
      for (final colorId in colorIds) (bodyColors: [colorId], isSpColor: true),
      for (final colorId in colorIds)
        (bodyColors: [colorId, colorId], isSpColor: false),
      for (var i = 0; i < colorIds.length; i++)
        for (var j = i + 1; j < colorIds.length; j++)
          (bodyColors: [colorIds[i], colorIds[j]], isSpColor: false),
    ];

    for (final candidate in candidates) {
      final result = candidate.calculateAttributeResistance(masterData);
      if (_mapEquals(_toMap(result), target)) {
        return candidate;
      }
    }

    return null;
  }
}

Map<String, int> _toMap(List<AttributeResistance> list) => {
  for (final resistance in list) resistance.attribute.id: resistance.value,
};

bool _mapEquals(Map<String, int> a, Map<String, int> b) {
  if (a.length != b.length) return false;
  for (final entry in a.entries) {
    if (b[entry.key] != entry.value) return false;
  }
  return true;
}
