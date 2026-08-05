import '../master_data/anntena.dart';
import '../master_data/body_color_resistance_rule.dart';
import '../master_data/head_shape.dart';
import '../master_data/master_data.dart';
import '../master_data/pattern.dart';
import '../master_data/personality.dart';
import '../master_data/physique.dart';
import 'abnormality_resistance.dart';
import 'attribute_resistance_calculator.dart';
import 'denpa_men.dart';
import 'denpa_men_validation_exception.dart';

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
    throw InvalidBodyColorCountException(bodyColors.length);
  }
  if (isSpColor && bodyColors.length != 1) {
    throw const SpColorRequiresSingleBodyColorException();
  }

  final rulesByColorId = {
    for (final rule in masterData.bodyColorResistanceRules) rule.colorId: rule,
  };

  for (final colorId in bodyColors) {
    _requireRule(rulesByColorId, colorId);
  }

  final draft = DenpaMen(
    abnormalityResistances: _abnormalityResistances(headShape),
    bodyColors: bodyColors,
    attributeResistance: const [],
    physique: physique,
    personality: personality,
    pattern: pattern,
    headShape: headShape,
    anntena: anntena,
    isSpColor: isSpColor,
  );

  return draft.copyWith(
    attributeResistance: draft.calculateAttributeResistance(masterData),
  );
}

BodyColorResistanceRule _requireRule(
  Map<String, BodyColorResistanceRule> rulesByColorId,
  String colorId,
) {
  final rule = rulesByColorId[colorId];
  if (rule == null) {
    throw UnknownBodyColorException(colorId);
  }
  return rule;
}

List<AbnormalityResistance> _abnormalityResistances(HeadShape headShape) {
  return [
    for (final entry in headShape.abnormalityResistanceBonuses.entries)
      AbnormalityResistance(abnormalityId: entry.key, value: entry.value),
  ];
}
