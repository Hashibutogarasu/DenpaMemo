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

  DenpaMen build(List<String> bodyColors) {
    return createDenpaMen(
      maxHappiness: 0,
      maxLevel: 1,
      name: 'test-denpa-men',
      bodyColors: bodyColors,
      isSpColor: false,
      headShape: const HeadShape(id: 'head-a'),
      physique: masterData.physiques.first,
      personality: masterData.personalities.first,
      pattern: masterData.patterns.first,
      anntena: const Anntena(id: 'anntena-a'),
      masterData: masterData,
    );
  }

  Map<String, int> abnormalityByAttribute(DenpaMen denpaMen) => {
    for (final r in denpaMen.abnormalityResistances) r.abnormalityId: r.value,
  };

  test('red + red grants burn +2', () {
    final result = abnormalityByAttribute(build(const ['red', 'red']));
    expect(result, {'burn': 2});
  });

  test('red + blue grants both burn +1 and soaked +1, not halved', () {
    final result = abnormalityByAttribute(build(const ['red', 'blue']));
    expect(result, {'burn': 1, 'soaked': 1});
  });

  test('solo black grants sleep +1', () {
    final result = abnormalityByAttribute(build(const ['black']));
    expect(result, {'sleep': 1});
  });
}
