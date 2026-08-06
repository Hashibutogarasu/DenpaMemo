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

  DenpaMen build(HeadShape headShape) {
    return createDenpaMen(
      maxHappiness: 0,
      maxLevel: 1,
      name: 'test-denpa-men',
      bodyColors: const ['black'],
      isSpColor: false,
      headShape: headShape,
      physique: masterData.physiques.first,
      personality: masterData.personalities.first,
      pattern: masterData.patterns.first,
      anntena: const Anntena(id: 'anntena-a', displayName: 'anntena-a'),
      masterData: masterData,
    );
  }

  Map<String, int> attributeByAttribute(DenpaMen denpaMen) => {
    for (final r in denpaMen.attributeResistance) r.attributeId: r.value,
  };

  test('bowlCut grants +1 to every attribute on top of black color +1', () {
    final result = attributeByAttribute(build(headShapeById('bowlCut')));
    for (final attribute in masterData.attributes) {
      expect(result[attribute.id], 2);
    }
  });

  test('light grants +2 to every attribute on top of black color +1', () {
    final result = attributeByAttribute(build(headShapeById('light')));
    for (final attribute in masterData.attributes) {
      expect(result[attribute.id], 3);
    }
  });

  test('fin grants +2 to every attribute on top of black color +1', () {
    final result = attributeByAttribute(build(headShapeById('fin')));
    for (final attribute in masterData.attributes) {
      expect(result[attribute.id], 3);
    }
  });

  test('moon grants +1 to every attribute on top of black color +1', () {
    final result = attributeByAttribute(build(headShapeById('moon')));
    for (final attribute in masterData.attributes) {
      expect(result[attribute.id], 2);
    }
  });

  test('sun (no attribute bonus of its own) leaves only black color +1', () {
    final result = attributeByAttribute(build(headShapeById('sun')));
    for (final attribute in masterData.attributes) {
      expect(result[attribute.id], 1);
    }
  });
}
