import '../master_data/legacy_antenna_id_migrations.dart';
import 'denpa_men_entity.dart';
import 'package:data_pack/data_pack.dart';

/// Converts a domain [DenpaMen] to its persisted [DenpaMenEntity] form,
/// keeping only master-data ids rather than the embedded objects.
extension DenpaMenEntityMapper on DenpaMen {
  DenpaMenEntity toEntity({int id = 0, required DateTime createdAt}) {
    return DenpaMenEntity(
      id: id,
      cuid: this.id,
      name: name,
      bodyColors: bodyColors,
      bodyColorShades: bodyColorShades,
      parentIds: parentIds,
      isSpColor: isSpColor,
      headShapeId: headShape.id,
      physiqueId: physique.id,
      personalityId: personality.id,
      patternId: pattern.id,
      anntenaId: anntena.id,
      antennaLevel: antennaLevel,
      happiness: happiness,
      maxHappiness: maxHappiness,
      level: level,
      maxLevel: maxLevel,
      currentExp: currentExp,
      maxExp: maxExp,
      hp: hp,
      ap: ap,
      attack: attack,
      defense: defense,
      speed: speed,
      evasionRate: evasionRate,
      correctionIds: corrections.map((correction) => correction.id).toList(),
      considerCorrections: considerCorrections,
      catchOrder: catchOrder,
      memo: memo,
      hash: hash,
      monsterExpMonsterId: monsterExp?.monsterId,
      monsterExpCount: monsterExp?.count,
      monsterExpValue: monsterExp?.exp,
      monsterExpLevel: monsterExp?.level,
      monsterExpMaxLevelTeammateCount: monsterExp?.maxLevelTeammateCount,
      monsterExpRecipientCount: monsterExp?.expRecipientCount,
      createdAt: createdAt,
      moveInDate: moveInDate,
    );
  }
}

/// Rebuilds the domain [DenpaMen] from a persisted [DenpaMenEntity] by
/// resolving its master-data id references against [masterData], the same
/// way `createDenpaMen` derives resistances for a freshly-edited entry.
extension DenpaMenEntityToDomain on DenpaMenEntity {
  DenpaMen toDomain(
    MasterData masterData, {
    AntennaIdMigrator antennaIdMigrator = const LegacyAntennaIdMigrator(),
  }) {
    final denpaMen = createDenpaMen(
      id: cuid,
      name: name,
      bodyColors: bodyColors,
      bodyColorShades: bodyColorShades,
      isSpColor: isSpColor,
      headShape: masterData.headShapes.firstWhere(
        (headShape) => headShape.id == headShapeId,
      ),
      physique: masterData.physiques.firstWhere(
        (physique) => physique.id == physiqueId,
      ),
      personality: masterData.personalities.firstWhere(
        (personality) => personality.id == personalityId,
      ),
      pattern: masterData.patterns.firstWhere(
        (pattern) => pattern.id == patternId,
      ),
      anntena: masterData.anntenas.firstWhere(
        (anntena) => anntena.id == antennaIdMigrator.migrate(anntenaId),
      ),
      antennaLevel: antennaLevel,
      masterData: masterData,
      happiness: happiness,
      maxHappiness: maxHappiness,
      level: level,
      maxLevel: maxLevel,
      currentExp: currentExp,
      maxExp: maxExp,
      hp: hp,
      ap: ap,
      attack: attack,
      defense: defense,
      speed: speed,
      evasionRate: evasionRate,
      corrections: correctionIds
          .map(
            (correctionId) => masterData.corrections.firstWhere(
              (correction) => correction.id == correctionId,
            ),
          )
          .toList(),
      considerCorrections: considerCorrections,
      parentIds: parentIds,
      catchOrder: catchOrder,
      qrCodeId: qrCode.target?.cuid,
      memo: memo,
      moveInDate: moveInDate,
      monsterExp: _monsterExpFromColumns(
        monsterId: monsterExpMonsterId,
        count: monsterExpCount,
        exp: monsterExpValue,
        level: monsterExpLevel,
        maxLevelTeammateCount: monsterExpMaxLevelTeammateCount,
        expRecipientCount: monsterExpRecipientCount,
      ),
    );
    return denpaMen.copyWith(hash: hash);
  }
}

MonsterExp? _monsterExpFromColumns({
  required String? monsterId,
  required int? count,
  required int? exp,
  required int? level,
  required int? maxLevelTeammateCount,
  required int? expRecipientCount,
}) {
  if (monsterId == null ||
      count == null ||
      exp == null ||
      level == null ||
      maxLevelTeammateCount == null ||
      expRecipientCount == null) {
    return null;
  }
  return MonsterExp(
    monsterId: monsterId,
    count: count,
    exp: exp,
    level: level,
    maxLevelTeammateCount: maxLevelTeammateCount,
    expRecipientCount: expRecipientCount,
  );
}
