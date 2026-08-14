import 'package:denpa_memo/data/master_data/json_master_data_repository.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  test('fireball deals fire damage', () async {
    final masterData = await JsonMasterDataRepository().load();

    final fireball = masterData.anntenas.firstWhere(
      (a) => a.id == 'fireball_all',
    );
    expect(fireball.dealsDamage, isTrue);
    expect(fireball.attackAttributes.map((a) => a.id), ['fire']);
  });

  test('heal deals no damage and has no attack attribute', () async {
    final masterData = await JsonMasterDataRepository().load();

    final heal = masterData.anntenas.firstWhere((a) => a.id == 'heal_solo_1');
    expect(heal.dealsDamage, isFalse);
    expect(heal.attackAttributes, isEmpty);
    expect(heal.maxLevel, 9);
    expect(heal.evolvesToId, 'heal_solo_2');
  });
}
