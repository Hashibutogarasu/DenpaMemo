import 'package:data_pack/data_pack.dart';
import 'package:denpa_memo/data/denpa_men/objectbox_denpa_men_repository.dart';
import 'package:denpa_memo/data/objectbox/objectbox.dart';
import 'package:flutter_test/flutter_test.dart';

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

  test('hasAnyDuplicateDenpaMen', () {
    final objectBox = ObjectBox.createInMemory();
    addTearDown(objectBox.store.close);
    final denpaMenRepository = ObjectBoxDenpaMenRepository(objectBox);

    final existing = createDenpaMen(
      name: 'existing',
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
    denpaMenRepository.save(existing);

    final unknown = createDenpaMen(
      name: 'unknown',
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

    expect(
      hasAnyDuplicateDenpaMen([unknown], denpaMenRepository, masterData),
      isFalse,
    );
    expect(
      hasAnyDuplicateDenpaMen([unknown, existing], denpaMenRepository, masterData),
      isTrue,
    );
    expect(
      hasAnyDuplicateDenpaMen(const [], denpaMenRepository, masterData),
      isFalse,
    );
  });
}
