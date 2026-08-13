import '../master_data/attribute_bonus.dart';
import '../master_data/master_data.dart';
import 'attribute_resistance.dart';

/// A body color selection (1 solo color, 2 distinct colors, or the same
/// color twice) together with its SP-color state.
typedef BodyColorSelection = ({List<String> bodyColors, bool isSpColor});

/// Derives the [AttributeResistance] list a body color selection produces
/// from [masterData]'s body color resistance rules, instead of accepting
/// resistance values directly.
extension AttributeResistanceCalculation on BodyColorSelection {
  List<AttributeResistance> calculateAttributeResistance(
    MasterData masterData,
  ) {
    final rulesByColorId = {
      for (final rule in masterData.bodyColorResistanceRules)
        rule.colorId: rule,
    };
    final ruleForColor = [
      for (final colorId in bodyColors) rulesByColorId[colorId]!,
    ];
    final attributeIdList = masterData.attributes
        .where((attribute) => attribute.isElemental)
        .map((attribute) => attribute.id)
        .toList();
    final attributeById = {
      for (final attribute in masterData.attributes) attribute.id: attribute,
    };

    final isSameColorPair =
        bodyColors.length == 2 && bodyColors[0] == bodyColors[1];
    final isDistinctColorPair = bodyColors.length == 2 && !isSameColorPair;
    final baseRule = isDistinctColorPair ? null : ruleForColor.first;

    final totals = <String, int>{};
    if (isDistinctColorPair) {
      for (final rule in ruleForColor) {
        for (final bonus in rule.attributeResistanceBonuses) {
          totals[bonus.attribute.id] =
              (totals[bonus.attribute.id] ?? 0) + bonus.bonus;
        }
      }
    } else {
      for (final bonus in baseRule!.attributeResistanceBonuses) {
        totals[bonus.attribute.id] = bonus.bonus;
      }
    }

    if (baseRule != null) {
      _applySoloOrPairEffects(
        totals: totals,
        ownBonuses: baseRule.attributeResistanceBonuses,
        attributeIdList: attributeIdList,
        isSpColor: isSpColor,
        isSameColorPair: isSameColorPair,
      );
    }

    if (isDistinctColorPair) {
      totals.updateAll((_, value) => value ~/ 2);
    }

    return [
      for (final entry in totals.entries)
        if (entry.value != 0)
          AttributeResistance(
            attribute: attributeById[entry.key]!,
            value: entry.value,
          ),
    ];
  }
}

void _applySoloOrPairEffects({
  required Map<String, int> totals,
  required List<AttributeBonus> ownBonuses,
  required List<String> attributeIdList,
  required bool isSpColor,
  required bool isSameColorPair,
}) {
  if (ownBonuses.isEmpty) {
    if (isSpColor) {
      for (final attributeId in attributeIdList) {
        totals[attributeId] = (totals[attributeId] ?? 0) + 1;
      }
    }
    return;
  }

  final hasOwnStrength = ownBonuses.any((bonus) => bonus.bonus > 0);
  final isFullNegativeCoverage =
      !hasOwnStrength && ownBonuses.length == attributeIdList.length;

  if (isSpColor) {
    if (hasOwnStrength) {
      totals.updateAll((_, value) => value < 0 ? 0 : value);
    } else if (isFullNegativeCoverage) {
      for (final attributeId in attributeIdList) {
        totals[attributeId] = -1;
      }
    }
  } else if (isSameColorPair) {
    if (hasOwnStrength) {
      totals.updateAll((_, value) {
        if (value > 0) return value + 1;
        if (value < 0) return value - 1;
        return value;
      });
    } else if (isFullNegativeCoverage) {
      totals.updateAll((_, value) => value + 1);
    }
  }
}
