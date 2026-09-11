import 'package:cuid2/cuid2.dart';

import '../master_data/anntena.dart';
import '../master_data/body_color_resistance_rule.dart';
import '../master_data/correction.dart';
import '../master_data/head_shape.dart';
import '../master_data/master_data.dart';
import '../master_data/pattern.dart';
import '../master_data/personality.dart';
import '../master_data/physique.dart';
import '../monster/monster_exp.dart';
import 'additional_correction.dart';
import 'denpa_men.dart';
import 'denpa_men_hash.dart';
import 'denpa_men_resistance_calculator.dart';
import 'denpa_men_validation_exception.dart';

/// Builds a [DenpaMen], validating [bodyColors] and deriving
/// [DenpaMen.attributeResistance] / [DenpaMen.abnormalityResistances] from
/// [masterData] instead of accepting them directly. The returned [DenpaMen]
/// holds base growth stats and resistances; [DenpaMen.corrections] are kept
/// as-is and only applied on top via
/// [DenpaMenCorrectionCalculation.applyCorrections] at display time, so
/// repeated edits never compound them.
DenpaMen createDenpaMen({
  String? id,
  required String name,
  required List<String> bodyColors,
  List<int> bodyColorShades = const [],
  required bool isSpColor,
  required HeadShape headShape,
  required Physique physique,
  int? physiqueColumnIndex,
  required Personality personality,
  required Pattern pattern,
  required Anntena anntena,
  int antennaLevel = 0,
  required MasterData masterData,
  int happiness = 0,
  required int maxHappiness,
  int level = 1,
  required int maxLevel,
  int? currentExp,
  int? maxExp,
  int hp = 0,
  int ap = 0,
  int attack = 0,
  int defense = 0,
  int speed = 0,
  int evasionRate = 0,
  List<Correction> corrections = const [],
  bool considerCorrections = true,
  AdditionalCorrection additionalCorrection = const AdditionalCorrection(),
  List<String> parentIds = const [],
  int? catchOrder,
  String? qrCodeId,
  String? memo,
  DateTime? moveInDate,
  MonsterExp? monsterExp,
  DenpaMenResistances? resistances,
}) {
  if (bodyColors.length != 1 && bodyColors.length != 2) {
    throw InvalidBodyColorCountException(bodyColors.length);
  }
  if (bodyColorShades.isNotEmpty &&
      bodyColorShades.length != bodyColors.length) {
    throw InvalidBodyColorShadeCountException(bodyColorShades.length);
  }
  if (isSpColor && bodyColors.length != 1) {
    throw const SpColorRequiresSingleBodyColorException();
  }
  if (parentIds.isNotEmpty && parentIds.length != 2) {
    throw InvalidParentCountException(parentIds.length);
  }

  final rulesByColorId = {
    for (final rule in masterData.bodyColorResistanceRules) rule.colorId: rule,
  };

  for (final colorId in bodyColors) {
    _requireRule(rulesByColorId, colorId);
  }

  final draft = DenpaMen(
    id: id == null || id.isEmpty ? cuid() : id,
    name: name,
    abnormalityResistances: const [],
    bodyColors: bodyColors,
    bodyColorShades: bodyColorShades.isEmpty
        ? List.filled(bodyColors.length, 0)
        : bodyColorShades,
    attributeResistance: const [],
    physique: physique,
    physiqueColumnIndex: physiqueColumnIndex,
    personality: personality,
    pattern: pattern,
    headShape: headShape,
    anntena: anntena,
    antennaLevel: antennaLevel,
    isSpColor: isSpColor,
    happiness: happiness,
    maxHappiness: maxHappiness,
    level: level,
    maxLevel: maxLevel,
    currentExp: currentExp,
    maxExp: maxExp,
    hp: hp,
    ap: ap,
    attack: attack,
    defense: defense,
    speed: speed,
    evasionRate: evasionRate,
    corrections: corrections,
    considerCorrections: considerCorrections,
    additionalCorrection: additionalCorrection,
    parentIds: parentIds,
    catchOrder: catchOrder,
    qrCodeId: qrCodeId,
    memo: memo == null || memo.isEmpty ? null : memo,
    moveInDate: moveInDate,
    monsterExp: monsterExp,
  );

  final resolvedResistances =
      resistances ?? draft.calculateResistances(masterData);
  final withResistances = draft.copyWith(
    abnormalityResistances: resolvedResistances.abnormalityResistances,
    attributeResistance: resolvedResistances.attributeResistance,
  );
  return withResistances.copyWith(hash: computeDenpaMenHash(withResistances));
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
