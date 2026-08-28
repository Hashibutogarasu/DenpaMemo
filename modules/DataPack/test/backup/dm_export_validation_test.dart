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

  test('isDenpaMenConsistentWithMasterData is true when references resolve', () {
    expect(isDenpaMenConsistentWithMasterData(denpaMen, masterData), isTrue);
  });

  test(
    'isDenpaMenConsistentWithMasterData is false when a reference is missing',
    () {
      final emptyMasterData = MasterData(
        headShapes: const [],
        anntenas: const [],
        attributes: const [],
        abnormalityTypes: const [],
        physiques: const [],
        personalities: const [],
        patterns: const [],
        bodyColorResistanceRules: const [],
        bodyColorAbnormalityResistanceRules: const [],
        corrections: const [],
      );

      expect(
        isDenpaMenConsistentWithMasterData(denpaMen, emptyMasterData),
        isFalse,
      );
    },
  );

  test('isDenpaMenOrphanedInExport', () {
    final withParents = denpaMen.copyWith(parentIds: ['parent-a', 'parent-b']);
    final noParents = denpaMen.copyWith(parentIds: const []);

    expect(
      isDenpaMenOrphanedInExport(withParents, {'parent-a', 'parent-b'}),
      isFalse,
    );
    expect(
      isDenpaMenOrphanedInExport(withParents, {'parent-a'}),
      isTrue,
    );
    expect(
      isDenpaMenOrphanedInExport(noParents, const {}),
      isFalse,
    );
  });
}
