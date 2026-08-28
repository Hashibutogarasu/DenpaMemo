import 'package:data_pack/data_pack.dart';
import 'package:test/test.dart';

void main() {
  final headShape = const HeadShape(id: 'head-a');
  final anntena = const Anntena(id: 'anntena-a', category: AnntenaCategory.other);
  final physique = const Physique(id: 'physique-a');
  final personality = const Personality(id: 'personality-a');
  final pattern = const Pattern(id: 'pattern-a');
  final colorId = 'color-a';

  final masterData = MasterData(
    headShapes: [headShape],
    anntenas: [anntena],
    attributes: const [],
    abnormalityTypes: const [],
    physiques: [physique],
    personalities: [personality],
    patterns: [pattern],
    bodyColorResistanceRules: [
      BodyColorResistanceRule(colorId: colorId, attributeResistanceBonuses: const []),
    ],
    bodyColorAbnormalityResistanceRules: const [],
    corrections: const [],
  );

  test('computeDenpaMenHash matches for the same content with different cuids', () {
    final a = createDenpaMen(
      id: 'cuid-a',
      name: 'same-name',
      bodyColors: [colorId],
      isSpColor: false,
      headShape: headShape,
      physique: physique,
      personality: personality,
      pattern: pattern,
      anntena: anntena,
      masterData: masterData,
      maxHappiness: 0,
      maxLevel: 1,
    );
    final b = createDenpaMen(
      id: 'cuid-b',
      name: 'same-name',
      bodyColors: [colorId],
      isSpColor: false,
      headShape: headShape,
      physique: physique,
      personality: personality,
      pattern: pattern,
      anntena: anntena,
      masterData: masterData,
      maxHappiness: 0,
      maxLevel: 1,
    );

    expect(computeDenpaMenHash(a), computeDenpaMenHash(b));
  });

  test(
    'computeDenpaMenHash ignores memo/catchOrder/qrCodeId/moveInDate',
    () {
      final base = createDenpaMen(
        name: 'same-name',
        bodyColors: [colorId],
        isSpColor: false,
        headShape: headShape,
        physique: physique,
        personality: personality,
        pattern: pattern,
        anntena: anntena,
        masterData: masterData,
        maxHappiness: 0,
        maxLevel: 1,
      );
      final touched = base.copyWith(
        memo: 'a memo',
        qrCodeId: 'some-qr-id',
        moveInDate: DateTime(2024),
      );

      expect(computeDenpaMenHash(base), computeDenpaMenHash(touched));
    },
  );

  test('computeDenpaMenHash changes when core fields change', () {
    final a = createDenpaMen(
      name: 'name-a',
      bodyColors: [colorId],
      isSpColor: false,
      headShape: headShape,
      physique: physique,
      personality: personality,
      pattern: pattern,
      anntena: anntena,
      masterData: masterData,
      maxHappiness: 0,
      maxLevel: 1,
    );
    final b = a.copyWith(name: 'name-b');

    expect(computeDenpaMenHash(a), isNot(computeDenpaMenHash(b)));
  });

  test('createDenpaMen sets hash to computeDenpaMenHash of the result', () {
    final denpaMen = createDenpaMen(
      name: 'test-denpa-men',
      bodyColors: [colorId],
      isSpColor: false,
      headShape: headShape,
      physique: physique,
      personality: personality,
      pattern: pattern,
      anntena: anntena,
      masterData: masterData,
      maxHappiness: 0,
      maxLevel: 1,
    );

    expect(denpaMen.hash, computeDenpaMenHash(denpaMen));
  });
}
