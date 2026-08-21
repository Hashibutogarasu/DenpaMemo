import 'package:denpa_memo/domain/backup/dm_export_validation.dart';
import 'package:denpa_memo/domain/denpa_men/denpa_men_factory.dart';
import 'package:denpa_memo/domain/master_data/anntena.dart';
import 'package:denpa_memo/domain/master_data/body_color_resistance_rule.dart';
import 'package:denpa_memo/domain/master_data/head_shape.dart';
import 'package:denpa_memo/domain/master_data/master_data.dart';
import 'package:denpa_memo/domain/master_data/pattern.dart';
import 'package:denpa_memo/domain/master_data/personality.dart';
import 'package:denpa_memo/domain/master_data/physique.dart';
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
