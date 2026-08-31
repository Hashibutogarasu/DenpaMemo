import 'package:data_pack/data_pack.dart';
import 'package:test/test.dart';

void main() {
  final attributeIdA = 'attribute-a';
  final attributeIdB = 'attribute-b';
  final abnormalityId = 'abnormality-a';
  final soloColorId = 'color-solo';
  final secondColorId = 'color-second';
  final soloAllBonusColorId = 'color-solo-all-bonus';
  final weaknessColorId = 'color-weakness';

  final headShape = HeadShape(
    id: 'head-a',
    abnormalityResistanceBonuses: {abnormalityId: 3},
  );
  final anntena = const Anntena(id: 'anntena-a', category: AnntenaCategory.other);
  final physique = const Physique(id: 'physique-a');
  final personality = const Personality(id: 'personality-a');
  final pattern = const Pattern(id: 'pattern-a');

  final attributeA = Attribute(id: attributeIdA, index: 0);
  final attributeB = Attribute(id: attributeIdB, index: 1);

  final masterData = MasterData(
    headShapes: [headShape],
    anntenas: [anntena],
    attributes: [attributeA, attributeB],
    abnormalityTypes: [],
    physiques: [physique],
    personalities: [personality],
    patterns: [pattern],
    bodyColorResistanceRules: [
      BodyColorResistanceRule(
        colorId: soloColorId,
        attributeResistanceBonuses: [(attribute: attributeA, bonus: 2)],
      ),
      BodyColorResistanceRule(
        colorId: secondColorId,
        attributeResistanceBonuses: [
          (attribute: attributeA, bonus: 4),
          (attribute: attributeB, bonus: 2),
        ],
      ),
      BodyColorResistanceRule(
        colorId: soloAllBonusColorId,
        attributeResistanceBonuses: const [],
      ),
      BodyColorResistanceRule(
        colorId: weaknessColorId,
        attributeResistanceBonuses: [
          (attribute: attributeA, bonus: 2),
          (attribute: attributeB, bonus: -2),
        ],
      ),
    ],
    bodyColorAbnormalityResistanceRules: const [],
    corrections: const [],
  );

  test('throws InvalidBodyColorCountException when bodyColors is empty', () {
    expect(
      () => createDenpaMen(
        maxHappiness: 0,
        maxLevel: 1,
        name: 'test-denpa-men',
        bodyColors: const [],
        isSpColor: false,
        headShape: headShape,
        physique: physique,
        personality: personality,
        pattern: pattern,
        anntena: anntena,
        masterData: masterData,
      ),
      throwsA(isA<InvalidBodyColorCountException>()),
    );
  });

  test(
    'throws InvalidBodyColorCountException when bodyColors has more than two colors',
    () {
      expect(
        () => createDenpaMen(
          maxHappiness: 0,
          maxLevel: 1,
          name: 'test-denpa-men',
          bodyColors: [soloColorId, secondColorId, soloAllBonusColorId],
          isSpColor: false,
          headShape: headShape,
          physique: physique,
          personality: personality,
          pattern: pattern,
          anntena: anntena,
          masterData: masterData,
        ),
        throwsA(isA<InvalidBodyColorCountException>()),
      );
    },
  );

  test(
    'throws SpColorRequiresSingleBodyColorException when isSpColor is true with two colors',
    () {
      expect(
        () => createDenpaMen(
          maxHappiness: 0,
          maxLevel: 1,
          name: 'test-denpa-men',
          bodyColors: [soloColorId, secondColorId],
          isSpColor: true,
          headShape: headShape,
          physique: physique,
          personality: personality,
          pattern: pattern,
          anntena: anntena,
          masterData: masterData,
        ),
        throwsA(isA<SpColorRequiresSingleBodyColorException>()),
      );
    },
  );

  test('derives abnormality resistances from headShape', () {
    final denpaMen = createDenpaMen(
      maxHappiness: 0,
      maxLevel: 1,
      name: 'test-denpa-men',
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

  test('solo color with no attribute resistance bonuses of its own grants none when not SP', () {
    final denpaMen = createDenpaMen(
      maxHappiness: 0,
      maxLevel: 1,
      name: 'test-denpa-men',
      bodyColors: [soloAllBonusColorId],
      isSpColor: false,
      headShape: headShape,
      physique: physique,
      personality: personality,
      pattern: pattern,
      anntena: anntena,
      masterData: masterData,
    );

    expect(
      denpaMen.attributeResistance.where(
        (r) => r.attribute.id == attributeIdA || r.attribute.id == attributeIdB,
      ),
      isEmpty,
    );
  });

  test('solo color with no attribute resistance bonuses of its own adds +1 to all when SP', () {
    final denpaMen = createDenpaMen(
      maxHappiness: 0,
      maxLevel: 1,
      name: 'test-denpa-men',
      bodyColors: [soloAllBonusColorId],
      isSpColor: true,
      headShape: headShape,
      physique: physique,
      personality: personality,
      pattern: pattern,
      anntena: anntena,
      masterData: masterData,
    );

    final resistanceA = denpaMen.attributeResistance.firstWhere(
      (r) => r.attribute.id == attributeIdA,
    );
    final resistanceB = denpaMen.attributeResistance.firstWhere(
      (r) => r.attribute.id == attributeIdB,
    );
    expect(resistanceA.value, 1);
    expect(resistanceB.value, 1);
  });

  test(
    'SP color zeroes out negative attribute resistance, leaving only the positive one',
    () {
      final denpaMen = createDenpaMen(
        maxHappiness: 0,
        maxLevel: 1,
        name: 'test-denpa-men',
        bodyColors: [weaknessColorId],
        isSpColor: true,
        headShape: headShape,
        physique: physique,
        personality: personality,
        pattern: pattern,
        anntena: anntena,
        masterData: masterData,
      );

      expect(
        denpaMen.attributeResistance.where((r) => r.attribute.id == attributeIdB),
        isEmpty,
      );
      final resistanceA = denpaMen.attributeResistance.firstWhere(
        (r) => r.attribute.id == attributeIdA,
      );
      expect(resistanceA.value, 2);
      expect(denpaMen.attributeResistance, hasLength(1));
    },
  );

  test('two colors halve the combined attribute resistance', () {
    final denpaMen = createDenpaMen(
      maxHappiness: 0,
      maxLevel: 1,
      name: 'test-denpa-men',
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
      (r) => r.attribute.id == attributeIdA,
    );
    final b = denpaMen.attributeResistance.firstWhere(
      (r) => r.attribute.id == attributeIdB,
    );
    expect(a.value, 3);
    expect(b.value, 1);
  });
}
