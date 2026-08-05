import '../master_data/anntena.dart';
import '../master_data/body_color_resistance_rule.dart';
import '../master_data/head_shape.dart';
import '../master_data/master_data.dart';
import '../master_data/pattern.dart';
import '../master_data/personality.dart';
import '../master_data/physique.dart';
import 'abnormality_resistance.dart';
import 'attribute_resistance.dart';
import 'denpa_men.dart';

/// Builds a [DenpaMen], validating [bodyColors] and deriving
/// [DenpaMen.attributeResistance] / [DenpaMen.abnormalityResistances] from
/// [masterData] instead of accepting them directly.
DenpaMen createDenpaMen({
  required List<String> bodyColors,
  required bool isSpColor,
  required HeadShape headShape,
  required Physique physique,
  required Personality personality,
  required Pattern pattern,
  required Anntena anntena,
  required MasterData masterData,
}) {
  if (bodyColors.length != 1 && bodyColors.length != 2) {
    throw ArgumentError.value(
      bodyColors,
      'bodyColors',
      'must contain exactly 1 or 2 colors',
    );
  }
  if (isSpColor && bodyColors.length != 1) {
    throw ArgumentError.value(
      isSpColor,
      'isSpColor',
      'can only be true when bodyColors has exactly 1 color',
    );
  }

  final rulesByColorId = {
    for (final rule in masterData.bodyColorResistanceRules) rule.colorId: rule,
  };

  final ruleForColor = <BodyColorResistanceRule>[
    for (final colorId in bodyColors) _requireRule(rulesByColorId, colorId),
  ];

  return DenpaMen(
    abnormalityResistances: _abnormalityResistances(headShape),
    bodyColors: bodyColors,
    attributeResistance: _attributeResistances(
      ruleForColor: ruleForColor,
      isSpColor: isSpColor,
      attributeIds: masterData.attributes.map((attribute) => attribute.id),
    ),
    physique: physique,
    personality: personality,
    pattern: pattern,
    headShape: headShape,
    anntena: anntena,
    isSpColor: isSpColor,
  );
}

BodyColorResistanceRule _requireRule(
  Map<String, BodyColorResistanceRule> rulesByColorId,
  String colorId,
) {
  final rule = rulesByColorId[colorId];
  if (rule == null) {
    throw ArgumentError.value(colorId, 'bodyColors', 'unknown body color id');
  }
  return rule;
}

List<AbnormalityResistance> _abnormalityResistances(HeadShape headShape) {
  return [
    for (final entry in headShape.abnormalityResistanceBonuses.entries)
      AbnormalityResistance(abnormalityId: entry.key, value: entry.value),
  ];
}

List<AttributeResistance> _attributeResistances({
  required List<BodyColorResistanceRule> ruleForColor,
  required bool isSpColor,
  required Iterable<String> attributeIds,
}) {
  final totals = <String, int>{};

  for (final rule in ruleForColor) {
    rule.attributeResistanceBonuses.forEach((attributeId, bonus) {
      totals[attributeId] = (totals[attributeId] ?? 0) + bonus;
    });
  }

  final soloRule = ruleForColor.length == 1 ? ruleForColor.first : null;
  final grantsAllAttributeBonus =
      isSpColor || (soloRule?.grantsAllAttributeResistanceBonusWhenSolo ?? false);
  if (grantsAllAttributeBonus) {
    for (final attributeId in attributeIds) {
      totals[attributeId] = (totals[attributeId] ?? 0) + 1;
    }
  }

  if (isSpColor) {
    final weaknessAttributeId = soloRule?.weaknessAttributeId;
    if (weaknessAttributeId != null) {
      totals[weaknessAttributeId] = 0;
    }
  }

  if (ruleForColor.length == 2) {
    totals.updateAll((_, value) => value ~/ 2);
  }

  return [
    for (final entry in totals.entries)
      AttributeResistance(attributeId: entry.key, value: entry.value),
  ];
}
