import 'package:denpa_memo/data/master_data/json_master_data_repository.dart';
import 'package:denpa_memo/domain/denpa_men/denpa_men_correction_calculator.dart';
import 'package:denpa_memo/domain/denpa_men/denpa_men_factory.dart';
import 'package:denpa_memo/domain/master_data/anntena.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  test(
    'head shape stat bonus and protagonist correction both add onto the '
    'base stat, without either erasing the other',
    () async {
      final masterData = await JsonMasterDataRepository().load();
      final sun = masterData.headShapes.firstWhere((h) => h.id == 'sun');
      final protagonist = masterData.corrections.firstWhere(
        (c) => c.id == 'protagonist',
      );
      final anntena = const Anntena(id: 'anntena-a');

      final denpaMen = createDenpaMen(
        maxHappiness: 0,
        maxLevel: 1,
        name: 'test-denpa-men',
        bodyColors: const ['black'],
        isSpColor: false,
        headShape: sun,
        physique: masterData.physiques.first,
        personality: masterData.personalities.first,
        pattern: masterData.patterns.first,
        anntena: anntena,
        masterData: masterData,
        hp: 100,
        attack: 1000,
        defense: 2000,
        corrections: [protagonist],
      );

      final corrected = denpaMen.applyCorrections();

      expect(denpaMen.hp, 100);
      expect(denpaMen.attack, 1000);
      expect(denpaMen.defense, 2000);

      expect(corrected.hp, 100 + protagonist.hpBonus);
      expect(corrected.attack, 1000 + sun.attackBonus);
      expect(corrected.defense, 2000 + sun.defenseBonus);
    },
  );

  test(
    'wing head shape grants speed/evasionRate bonus on top of the base '
    'stat, with no corrections selected',
    () async {
      final masterData = await JsonMasterDataRepository().load();
      final wing = masterData.headShapes.firstWhere((h) => h.id == 'wing');
      final anntena = const Anntena(id: 'anntena-a');

      final denpaMen = createDenpaMen(
        maxHappiness: 0,
        maxLevel: 1,
        name: 'test-denpa-men',
        bodyColors: const ['black'],
        isSpColor: false,
        headShape: wing,
        physique: masterData.physiques.first,
        personality: masterData.personalities.first,
        pattern: masterData.patterns.first,
        anntena: anntena,
        masterData: masterData,
        speed: 500,
        evasionRate: 10,
      );

      final corrected = denpaMen.applyCorrections();

      expect(corrected.speed, 500 + wing.speedBonus);
      expect(corrected.evasionRate, 10 + wing.evasionRateBonus);
    },
  );
}
