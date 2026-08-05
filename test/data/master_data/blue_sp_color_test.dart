import 'package:denpa_memo/data/master_data/json_master_data_repository.dart';
import 'package:denpa_memo/domain/master_data/anntena.dart';
import 'package:denpa_memo/domain/master_data/head_shape.dart';
import 'package:denpa_memo/domain/denpa_men/denpa_men_factory.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  test('blue becomes only water +2 when turned into an SP color', () async {
    final masterData = await JsonMasterDataRepository().load();

    final denpaMen = createDenpaMen(
      name: 'test-denpa-men',
      bodyColors: const ['blue'],
      isSpColor: true,
      headShape: const HeadShape(id: 'head-a', displayName: 'head-a'),
      physique: masterData.physiques.first,
      personality: masterData.personalities.first,
      pattern: masterData.patterns.first,
      anntena: const Anntena(id: 'anntena-a', displayName: 'anntena-a'),
      masterData: masterData,
    );

    expect(denpaMen.attributeResistance, hasLength(1));
    final water = denpaMen.attributeResistance.single;
    expect(water.attributeId, 'water');
    expect(water.value, 2);
  });
}
