import 'package:denpa_memo/data/master_data/json_master_data_repository.dart';
import 'package:denpa_memo/domain/denpa_men/denpa_men.dart';
import 'package:denpa_memo/domain/denpa_men/denpa_men_factory.dart';
import 'package:denpa_memo/domain/master_data/anntena.dart';
import 'package:denpa_memo/domain/master_data/head_shape.dart';
import 'package:denpa_memo/domain/master_data/master_data.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late MasterData masterData;

  setUpAll(() async {
    masterData = await JsonMasterDataRepository().load();
  });

  HeadShape headShapeById(String id) =>
      masterData.headShapes.firstWhere((h) => h.id == id);

  // Body color 'red' also grants burn +1 (see
  // body_color_abnormality_resistance.json), so every expectation below
  // includes that on top of the head shape's own bonuses.
  DenpaMen build(HeadShape headShape) {
    return createDenpaMen(
      name: 'test-denpa-men',
      bodyColors: const ['red'],
      isSpColor: false,
      headShape: headShape,
      physique: masterData.physiques.first,
      personality: masterData.personalities.first,
      pattern: masterData.patterns.first,
      anntena: const Anntena(id: 'anntena-a', displayName: 'anntena-a'),
      masterData: masterData,
    );
  }

  Map<String, int> abnormalityByAttribute(DenpaMen denpaMen) => {
    for (final r in denpaMen.abnormalityResistances) r.abnormalityId: r.value,
  };

  test('ring grants +3 charm, plus red color +1 burn', () {
    final result = abnormalityByAttribute(build(headShapeById('ring')));
    expect(result, {'charm': 3, 'burn': 1});
  });

  test(
    'sun grants +3 to every regular abnormality but not jack, plus red color +1 burn',
    () {
      final result = abnormalityByAttribute(build(headShapeById('sun')));
      expect(result.containsKey('jack'), isFalse);
      expect(result.length, 14);
      expect(result['burn'], 4);
      for (final entry in result.entries) {
        if (entry.key == 'burn') continue;
        expect(entry.value, 3);
      }
    },
  );

  test(
    'silkHat grants +2 to every regular abnormality and +1 jack, plus red color +1 burn',
    () {
      final result = abnormalityByAttribute(build(headShapeById('silkHat')));
      expect(result['jack'], 1);
      expect(result['burn'], 3);
      for (final entry in result.entries) {
        if (entry.key == 'jack' || entry.key == 'burn') continue;
        expect(entry.value, 2);
      }
    },
  );

  test('bowlCut only grants +1 jack, plus red color +1 burn', () {
    final result = abnormalityByAttribute(build(headShapeById('bowlCut')));
    expect(result, {'jack': 1, 'burn': 1});
  });

  test('castleTower grants +2 jack only, plus red color +1 burn', () {
    final result = abnormalityByAttribute(build(headShapeById('castleTower')));
    expect(result, {'jack': 2, 'burn': 1});
  });

  test('grandCastleTower grants +3 jack only, plus red color +1 burn', () {
    final result = abnormalityByAttribute(
      build(headShapeById('grandCastleTower')),
    );
    expect(result, {'jack': 3, 'burn': 1});
  });

  test(
    'frog grants +1 to every regular abnormality and +1 jack, plus red color +1 burn',
    () {
      final result = abnormalityByAttribute(build(headShapeById('frog')));
      expect(result['jack'], 1);
      expect(result['burn'], 2);
      for (final entry in result.entries) {
        if (entry.key == 'jack' || entry.key == 'burn') continue;
        expect(entry.value, 1);
      }
    },
  );

  test('bread grants +2 fear, plus red color +1 burn', () {
    final result = abnormalityByAttribute(build(headShapeById('bread')));
    expect(result, {'fear': 2, 'burn': 1});
  });
}
