import 'package:denpa_memo/data/master_data/legacy_antenna_id_migrations.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  const migrator = LegacyAntennaIdMigrator();

  test('migrates pre-split antenna ids to their default variant', () {
    expect(migrator.migrate('waterGun'), 'waterGun_all');
    expect(migrator.migrate('beam'), 'beam_all');
    expect(migrator.migrate('fireball'), 'fireball_all');
    expect(migrator.migrate('heal'), 'heal_solo_1');
  });

  test('leaves unaffected ids unchanged', () {
    expect(migrator.migrate('revive'), 'revive');
    expect(migrator.migrate('waterGun_all'), 'waterGun_all');
  });
}
