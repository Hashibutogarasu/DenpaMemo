import 'package:denpa_memo/data/denpa_men/objectbox_denpa_men_repository.dart';
import 'package:denpa_memo/data/objectbox/objectbox.dart';
import 'package:denpa_memo/domain/denpa_men/denpa_men_factory.dart';
import 'package:denpa_memo/domain/denpa_men/denpa_men_hash.dart';
import 'package:denpa_memo/domain/denpa_men/denpa_men_hash_migration.dart';
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

  test('migrateDenpaMenHashes fixes stale/missing hashes', () {
    final objectBox = ObjectBox.createInMemory();
    addTearDown(objectBox.store.close);
    final denpaMenRepository = ObjectBoxDenpaMenRepository(objectBox);

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
    ).copyWith(hash: '');
    final id = denpaMenRepository.save(denpaMen);

    migrateDenpaMenHashes(denpaMenRepository, masterData);

    final migrated = denpaMenRepository
        .getAll(masterData)
        .firstWhere((record) => record.id == id);
    expect(migrated.denpaMen.hash, computeDenpaMenHash(migrated.denpaMen));
    expect(migrated.denpaMen.hash, isNot(''));
  });
}
