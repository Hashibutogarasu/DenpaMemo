abstract interface class AntennaIdMigrator {
  String migrate(String id);
}

class LegacyAntennaIdMigrator implements AntennaIdMigrator {
  const LegacyAntennaIdMigrator();

  static const _legacyIds = <String, String>{
    'waterGun': 'waterGun_all',
    'beam': 'beam_all',
    'fireball': 'fireball_all',
    'heal': 'heal_solo_1',
    'staticElectricity': 'staticElectricity_all',
    'sharpIce': 'sharpIce_all',
    'fallingRock': 'fallingRock_all',
    'knockdown': 'knockdown_solo_1',
  };

  @override
  String migrate(String id) => _legacyIds[id] ?? id;
}
