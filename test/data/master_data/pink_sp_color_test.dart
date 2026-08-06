import 'package:denpa_memo/data/master_data/json_master_data_repository.dart';
import 'package:denpa_memo/domain/master_data/anntena.dart';
import 'package:denpa_memo/domain/master_data/head_shape.dart';
import 'package:denpa_memo/domain/denpa_men/denpa_men_factory.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  test('pink becomes -1 on every attribute when made SP', () async {
    final masterData = await JsonMasterDataRepository().load();

    final denpaMen = createDenpaMen(
      maxHappiness: 0,
      maxLevel: 1,
      name: 'test-denpa-men',
      bodyColors: const ['pink'],
      isSpColor: true,
      headShape: const HeadShape(id: 'head-a'),
      physique: masterData.physiques.first,
      personality: masterData.personalities.first,
      pattern: masterData.patterns.first,
      anntena: const Anntena(id: 'anntena-a'),
      masterData: masterData,
    );

    expect(denpaMen.attributeResistance, hasLength(masterData.attributes.length));
    for (final resistance in denpaMen.attributeResistance) {
      expect(resistance.value, -1);
    }
  });
}
