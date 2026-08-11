import 'package:denpa_memo/data/master_data/json_master_data_repository.dart';
import 'package:denpa_memo/domain/master_data/anntena.dart';
import 'package:denpa_memo/domain/master_data/head_shape.dart';
import 'package:denpa_memo/domain/denpa_men/denpa_men_factory.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  test('white + white reinforces to light +3, dark -3', () async {
    final masterData = await JsonMasterDataRepository().load();

    final denpaMen = createDenpaMen(
      maxHappiness: 0,
      maxLevel: 1,
      name: 'test-denpa-men',
      bodyColors: const ['white', 'white'],
      isSpColor: false,
      headShape: const HeadShape(id: 'head-a'),
      physique: masterData.physiques.first,
      personality: masterData.personalities.first,
      pattern: masterData.patterns.first,
      anntena: const Anntena(id: 'anntena-a', category: AnntenaCategory.other),
      masterData: masterData,
    );

    final byAttribute = {
      for (final r in denpaMen.attributeResistance) r.attributeId: r.value,
    };

    expect(byAttribute, {'light': 3, 'dark': -3});
  });
}
