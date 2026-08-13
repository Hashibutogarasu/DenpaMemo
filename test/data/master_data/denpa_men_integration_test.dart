import 'package:denpa_memo/data/master_data/json_master_data_repository.dart';
import 'package:denpa_memo/domain/denpa_men/attribute_resistance_reverse_calculator.dart';
import 'package:denpa_memo/domain/denpa_men/denpa_men.dart';
import 'package:denpa_memo/domain/denpa_men/denpa_men_factory.dart';
import 'package:denpa_memo/domain/master_data/anntena.dart';
import 'package:denpa_memo/domain/master_data/head_shape.dart';
import 'package:denpa_memo/domain/master_data/master_data.dart';
import 'package:denpa_memo/domain/master_data/pattern.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late MasterData masterData;

  setUpAll(() async {
    masterData = await JsonMasterDataRepository().load();
  });

  HeadShape headShapeById(String id) =>
      masterData.headShapes.firstWhere((h) => h.id == id);

  Pattern patternById(String id) =>
      masterData.patterns.firstWhere((p) => p.id == id);

  DenpaMen build({
    required String headShapeId,
    required List<String> bodyColors,
    required String patternId,
  }) {
    return createDenpaMen(
      maxHappiness: 0,
      maxLevel: 1,
      name: 'test-denpa-men',
      bodyColors: bodyColors,
      isSpColor: false,
      headShape: headShapeById(headShapeId),
      physique: masterData.physiques.first,
      personality: masterData.personalities.first,
      pattern: patternById(patternId),
      anntena: const Anntena(id: 'anntena-a', category: AnntenaCategory.other),
      masterData: masterData,
    );
  }

  Map<String, int> attributeByAttribute(DenpaMen denpaMen) => {
    for (final r in denpaMen.attributeResistance) r.attribute.id: r.value,
  };

  Map<String, int> abnormalityByAttribute(DenpaMen denpaMen) => {
    for (final r in denpaMen.abnormalityResistances) r.abnormalityId: r.value,
  };

  test('sun + gold/red + pattern C', () {
    final denpaMen = build(
      headShapeId: 'sun',
      bodyColors: const ['gold', 'red'],
      patternId: 'c',
    );

    expect(attributeByAttribute(denpaMen), {'water': -1, 'dark': -1});

    final abnormality = abnormalityByAttribute(denpaMen);
    expect(abnormality.containsKey('jack'), isFalse);
    expect(abnormality['paralysis'], 4);
    expect(abnormality['burn'], 4);
    for (final entry in abnormality.entries) {
      if (entry.key == 'paralysis' || entry.key == 'burn') continue;
      expect(entry.value, 3);
    }

    final found = denpaMen.attributeResistance.findColorCombination(
      masterData,
    );
    expect(found, isNotNull);
    final reconstructed = build(
      headShapeId: 'sun',
      bodyColors: found!.bodyColors,
      patternId: 'c',
    );
    expect(attributeByAttribute(reconstructed), attributeByAttribute(denpaMen));
  });

  test('fin + purple/black + pattern D', () {
    final denpaMen = build(
      headShapeId: 'fin',
      bodyColors: const ['purple', 'black'],
      patternId: 'd',
    );

    expect(attributeByAttribute(denpaMen), {
      'fire': 2,
      'water': 2,
      'thunder': 2,
      'earth': 2,
      'ice': 2,
      'wind': 2,
      'light': 1,
      'dark': 3,
    });

    expect(abnormalityByAttribute(denpaMen), {'curse': 1, 'sleep': 1});
  });

  test('silkHat + red/purple + pattern D', () {
    final denpaMen = build(
      headShapeId: 'silkHat',
      bodyColors: const ['red', 'purple'],
      patternId: 'd',
    );

    final attribute = attributeByAttribute(denpaMen);
    expect(attribute.containsKey('water'), isFalse);
    expect(attribute.containsKey('light'), isFalse);
    expect(attribute['fire'], 2);
    expect(attribute['dark'], 2);
    for (final entry in attribute.entries) {
      if (entry.key == 'fire' || entry.key == 'dark') continue;
      expect(entry.value, 1);
    }
    expect(attribute, hasLength(6));

    final abnormality = abnormalityByAttribute(denpaMen);
    expect(abnormality['jack'], 1);
    expect(abnormality['burn'], 3);
    expect(abnormality['curse'], 3);
    for (final entry in abnormality.entries) {
      if (['jack', 'burn', 'curse'].contains(entry.key)) continue;
      expect(entry.value, 2);
    }
  });
}
