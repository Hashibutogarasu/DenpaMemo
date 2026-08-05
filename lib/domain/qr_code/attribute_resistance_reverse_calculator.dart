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

    for (final colorId in colorIds) {
      for (final isSpColor in [false, true]) {
        final candidate = (bodyColors: [colorId], isSpColor: isSpColor);
        if (_matches(candidate, target, masterData)) {
          return candidate;
        }
      }
    }

    for (final colorId in colorIds) {
      final candidate = (bodyColors: [colorId, colorId], isSpColor: false);
      if (_matches(candidate, target, masterData)) {
        return candidate;
      }
    }

    for (var i = 0; i < colorIds.length; i++) {
      for (var j = i + 1; j < colorIds.length; j++) {
        final candidate = (
          bodyColors: [colorIds[i], colorIds[j]],
          isSpColor: false,
        );
        if (_matches(candidate, target, masterData)) {
          return candidate;
        }
      }
    }

    return null;
  }
}

bool _matches(
  BodyColorSelection candidate,
  Map<String, int> target,
  MasterData masterData,
) {
  final result = candidate.calculateAttributeResistance(masterData);
  return _mapEquals(_toMap(result), target);
}

Map<String, int> _toMap(List<AttributeResistance> list) => {
  for (final resistance in list) resistance.attributeId: resistance.value,
};

bool _mapEquals(Map<String, int> a, Map<String, int> b) {
  if (a.length != b.length) return false;
  for (final entry in a.entries) {
    if (b[entry.key] != entry.value) return false;
  }
  return true;
}
