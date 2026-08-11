import 'package:denpa_memo/data/master_data/json_master_data_repository.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  test(
    'loads every antenna file from attack/support/other subdirectories',
    () async {
      final masterData = await JsonMasterDataRepository().load();

      expect(masterData.anntenas, hasLength(52));

      final ids = masterData.anntenas.map((a) => a.id).toSet();
      expect(ids, contains('revive_solo_1'));
      expect(ids, contains('excite_solo_1'));
      expect(ids, contains('fireball_all'));
      expect(ids, contains('antennaRoot'));
      expect(ids, contains('none'));
      expect(ids.length, 52);
    },
  );

  test('fireball deals fire damage', () async {
    final masterData = await JsonMasterDataRepository().load();

    final fireball = masterData.anntenas.firstWhere(
      (a) => a.id == 'fireball_all',
    );
    expect(fireball.dealsDamage, isTrue);
    expect(fireball.attackAttributeId, 'fire');
  });

  test('heal deals no damage and has no attack attribute', () async {
    final masterData = await JsonMasterDataRepository().load();

    final heal = masterData.anntenas.firstWhere((a) => a.id == 'heal_solo_1');
    expect(heal.dealsDamage, isFalse);
    expect(heal.attackAttributeId, isNull);
    expect(heal.maxLevel, 9);
    expect(heal.evolvesToId, 'heal_solo_2');
  });
}
