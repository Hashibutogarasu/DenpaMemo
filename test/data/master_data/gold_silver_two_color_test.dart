import 'package:denpa_memo/data/master_data/json_master_data_repository.dart';
import 'package:denpa_memo/domain/master_data/anntena.dart';
import 'package:denpa_memo/domain/master_data/head_shape.dart';
import 'package:denpa_memo/domain/qr_code/denpa_men_factory.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  test(
    'gold + silver halves to fire -1, thunder -1, water -1, dark -1',
    () async {
      final masterData = await JsonMasterDataRepository().load();

      final denpaMen = createDenpaMen(
        bodyColors: const ['gold', 'silver'],
        isSpColor: false,
        headShape: const HeadShape(id: 'head-a', displayName: 'head-a'),
        physique: masterData.physiques.first,
        personality: masterData.personalities.first,
        pattern: masterData.patterns.first,
        anntena: const Anntena(id: 'anntena-a', displayName: 'anntena-a'),
        masterData: masterData,
      );

      final byAttribute = {
        for (final r in denpaMen.attributeResistance) r.attributeId: r.value,
      };

      expect(byAttribute, {
        'fire': -1,
        'thunder': -1,
        'water': -1,
        'dark': -1,
      });
    },
  );
}
