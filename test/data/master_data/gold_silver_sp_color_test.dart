import 'package:denpa_memo/data/master_data/json_master_data_repository.dart';
import 'package:denpa_memo/domain/master_data/anntena.dart';
import 'package:denpa_memo/domain/master_data/head_shape.dart';
import 'package:denpa_memo/domain/master_data/master_data.dart';
import 'package:denpa_memo/domain/denpa_men/denpa_men.dart';
import 'package:denpa_memo/domain/denpa_men/denpa_men_factory.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late MasterData masterData;

  setUpAll(() async {
    masterData = await JsonMasterDataRepository().load();
  });

  DenpaMen buildSpColor(String colorId) {
    return createDenpaMen(
      maxHappiness: 0,
      maxLevel: 1,
      name: 'test-denpa-men',
      bodyColors: [colorId],
      isSpColor: true,
      headShape: const HeadShape(id: 'head-a', displayName: 'head-a'),
      physique: masterData.physiques.first,
      personality: masterData.personalities.first,
      pattern: masterData.patterns.first,
      anntena: const Anntena(id: 'anntena-a', displayName: 'anntena-a'),
      masterData: masterData,
    );
  }

  test('gold keeps its negative attribute resistances when made SP', () {
    final denpaMen = buildSpColor('gold');

    final fire = denpaMen.attributeResistance.firstWhere(
      (r) => r.attributeId == 'fire',
    );
    final dark = denpaMen.attributeResistance.firstWhere(
      (r) => r.attributeId == 'dark',
    );
    expect(fire.value, -2);
    expect(dark.value, -2);
  });

  test('silver keeps its negative attribute resistances when made SP', () {
    final denpaMen = buildSpColor('silver');

    final thunder = denpaMen.attributeResistance.firstWhere(
      (r) => r.attributeId == 'thunder',
    );
    final water = denpaMen.attributeResistance.firstWhere(
      (r) => r.attributeId == 'water',
    );
    expect(thunder.value, -2);
    expect(water.value, -2);
  });
}
