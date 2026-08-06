import 'package:denpa_memo/data/master_data/json_master_data_repository.dart';
import 'package:denpa_memo/domain/master_data/anntena.dart';
import 'package:denpa_memo/domain/master_data/head_shape.dart';
import 'package:denpa_memo/domain/denpa_men/denpa_men_factory.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  test(
    'protagonist correction adds HP +12 and suddenDeath resistance +2 on top of the base calculation',
    () async {
      final masterData = await JsonMasterDataRepository().load();
      final headShape = const HeadShape(id: 'head-a');
      final anntena = const Anntena(id: 'anntena-a');
      final protagonist = masterData.corrections.firstWhere(
        (c) => c.id == 'protagonist',
      );

      final withoutCorrection = createDenpaMen(
        maxHappiness: 0,
        maxLevel: 1,
        name: 'test-denpa-men',
        bodyColors: const ['black'],
        isSpColor: false,
        headShape: headShape,
        physique: masterData.physiques.first,
        personality: masterData.personalities.first,
        pattern: masterData.patterns.first,
        anntena: anntena,
        masterData: masterData,
        hp: 100,
      );

      final withCorrection = createDenpaMen(
        maxHappiness: 0,
        maxLevel: 1,
        name: 'test-denpa-men',
        bodyColors: const ['black'],
        isSpColor: false,
        headShape: headShape,
        physique: masterData.physiques.first,
        personality: masterData.personalities.first,
        pattern: masterData.patterns.first,
        anntena: anntena,
        masterData: masterData,
        hp: 100,
        corrections: [protagonist],
      );

      expect(withCorrection.hp, withoutCorrection.hp + 12);
      expect(
        withCorrection.abnormalityResistances
            .firstWhere((r) => r.abnormalityId == 'suddenDeath')
            .value,
        2,
      );
    },
  );
}
