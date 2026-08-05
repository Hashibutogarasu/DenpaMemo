import 'package:denpa_memo/domain/master_data/anntena.dart';
import 'package:denpa_memo/domain/master_data/attribute.dart';
import 'package:denpa_memo/domain/master_data/body_color_resistance_rule.dart';
import 'package:denpa_memo/domain/master_data/head_shape.dart';
import 'package:denpa_memo/domain/master_data/master_data.dart';
import 'package:denpa_memo/domain/master_data/pattern.dart';
import 'package:denpa_memo/domain/master_data/personality.dart';
import 'package:denpa_memo/domain/master_data/physique.dart';
import 'package:denpa_memo/domain/qr_code/denpa_men_factory.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final attributeIdA = 'attribute-a';
  final attributeIdB = 'attribute-b';
  final abnormalityId = 'abnormality-a';
  final soloColorId = 'color-solo';
  final secondColorId = 'color-second';
  final soloAllBonusColorId = 'color-solo-all-bonus';

  final headShape = HeadShape(
    id: 'head-a',
    displayName: 'head-a',
    abnormalityResistanceBonuses: {abnormalityId: 3},
  );
  final anntena = const Anntena(id: 'anntena-a', displayName: 'anntena-a');
  final physique = const Physique(id: 'physique-a', displayName: 'physique-a');
  final personality = const Personality(
    id: 'personality-a',
    displayName: 'personality-a',
  );
  final pattern = const Pattern(id: 'pattern-a', displayName: 'pattern-a');

  final masterData = MasterData(
    headShapes: [headShape],
    anntenas: [anntena],
    attributes: [
      Attribute(id: attributeIdA, displayName: attributeIdA),
      Attribute(id: attributeIdB, displayName: attributeIdB),
    ],
    abnormalityTypes: [],
    physiques: [physique],
    personalities: [personality],
    patterns: [pattern],
    bodyColorResistanceRules: [
      BodyColorResistanceRule(
        colorId: soloColorId,
        attributeResistanceBonuses: {attributeIdA: 2},
        weaknessAttributeId: attributeIdB,
      ),
      BodyColorResistanceRule(
        colorId: secondColorId,
        attributeResistanceBonuses: {attributeIdA: 4, attributeIdB: 2},
      ),
      BodyColorResistanceRule(
        colorId: soloAllBonusColorId,
        attributeResistanceBonuses: {attributeIdA: 1},
        grantsAllAttributeResistanceBonusWhenSolo: true,
      ),
    ],
  );

  test('throws when bodyColors is empty', () {
    expect(
      () => createDenpaMen(
        bodyColors: const [],
        isSpColor: false,
        headShape: headShape,
        physique: physique,
        personality: personality,
        pattern: pattern,
        anntena: anntena,
        masterData: masterData,
      ),
      throwsArgumentError,
    );
  });

  test('throws when bodyColors has more than two colors', () {
    expect(
      () => createDenpaMen(
        bodyColors: [soloColorId, secondColorId, soloAllBonusColorId],
        isSpColor: false,
        headShape: headShape,
        physique: physique,
        personality: personality,
        pattern: pattern,
        anntena: anntena,
        masterData: masterData,
      ),
      throwsArgumentError,
    );
  });

  test('throws when isSpColor is true with two colors', () {
    expect(
      () => createDenpaMen(
        bodyColors: [soloColorId, secondColorId],
        isSpColor: true,
        headShape: headShape,
        physique: physique,
        personality: personality,
        pattern: pattern,
        anntena: anntena,
        masterData: masterData,
      ),
      throwsArgumentError,
    );
  });

  test('derives abnormality resistances from headShape', () {
    final denpaMen = createDenpaMen(
      bodyColors: [soloColorId],
      isSpColor: false,
      headShape: headShape,
      physique: physique,
      personality: personality,
      pattern: pattern,
      anntena: anntena,
      masterData: masterData,
    );

    expect(
      denpaMen.abnormalityResistances.single.abnormalityId,
      abnormalityId,
    );
    expect(denpaMen.abnormalityResistances.single.value, 3);
  });

  test('solo color with grantsAllAttributeResistanceBonusWhenSolo adds +1', () {
    final denpaMen = createDenpaMen(
      bodyColors: [soloAllBonusColorId],
      isSpColor: false,
      headShape: headShape,
      physique: physique,
      personality: personality,
      pattern: pattern,
      anntena: anntena,
      masterData: masterData,
    );

    final resistance = denpaMen.attributeResistance.firstWhere(
      (r) => r.attributeId == attributeIdA,
    );
    expect(resistance.value, 2);
  });

  test('SP color negates the weakness attribute', () {
    final denpaMen = createDenpaMen(
      bodyColors: [soloColorId],
      isSpColor: true,
      headShape: headShape,
      physique: physique,
      personality: personality,
      pattern: pattern,
      anntena: anntena,
      masterData: masterData,
    );

    final weakness = denpaMen.attributeResistance.firstWhere(
      (r) => r.attributeId == attributeIdB,
    );
    expect(weakness.value, 0);
  });

  test('two colors halve the combined attribute resistance', () {
    final denpaMen = createDenpaMen(
      bodyColors: [soloColorId, secondColorId],
      isSpColor: false,
      headShape: headShape,
      physique: physique,
      personality: personality,
      pattern: pattern,
      anntena: anntena,
      masterData: masterData,
    );

    final a = denpaMen.attributeResistance.firstWhere(
      (r) => r.attributeId == attributeIdA,
    );
    final b = denpaMen.attributeResistance.firstWhere(
      (r) => r.attributeId == attributeIdB,
    );
    expect(a.value, 3);
    expect(b.value, 1);
  });
}
