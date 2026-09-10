import 'package:data_cache/data_cache.dart';
import 'package:data_pack/data_pack.dart';

import '../master_data/legacy_antenna_id_migrations.dart';
import 'denpa_men_entity.dart';

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
      physiqueColumnIndex: physiqueColumnIndex,
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
      userAddedAttributeResistanceIds: userAddedAttributeResistances
          .map((resistance) => resistance.attribute.id)
          .toList(),
      userAddedAttributeResistanceValues: userAddedAttributeResistances
          .map((resistance) => resistance.value)
          .toList(),
      userAddedAttributeResistanceName: userAddedAttributeResistanceName,
      userAddedAbnormalityResistanceIds: userAddedAbnormalityResistances
          .map((resistance) => resistance.abnormalityId)
          .toList(),
      userAddedAbnormalityResistanceValues: userAddedAbnormalityResistances
          .map((resistance) => resistance.value)
          .toList(),
      userAddedAbnormalityResistanceName: userAddedAbnormalityResistanceName,
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
    CacheIndexRepository? cacheIndexRepository,
  }) {
    final resistances = cacheIndexRepository == null
        ? null
        : _resistancesFromCache(cacheIndexRepository, cuid);
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
      physiqueColumnIndex: physiqueColumnIndex,
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
      userAddedAttributeResistances: [
        for (var i = 0; i < userAddedAttributeResistanceIds.length; i++)
          AttributeResistance(
            attribute: masterData.attributes.firstWhere(
              (attribute) => attribute.id == userAddedAttributeResistanceIds[i],
            ),
            value: userAddedAttributeResistanceValues[i],
          ),
      ],
      userAddedAttributeResistanceName: userAddedAttributeResistanceName,
      userAddedAbnormalityResistances: [
        for (var i = 0; i < userAddedAbnormalityResistanceIds.length; i++)
          AbnormalityResistance(
            abnormalityId: userAddedAbnormalityResistanceIds[i],
            value: userAddedAbnormalityResistanceValues[i],
          ),
      ],
      userAddedAbnormalityResistanceName: userAddedAbnormalityResistanceName,
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
      resistances: resistances,
    );
    return denpaMen.copyWith(hash: hash);
  }
}

DenpaMenResistances? _resistancesFromCache(
  CacheIndexRepository cacheIndexRepository,
  String cuid,
) {
  final cached = cacheIndexRepository
      .readSync<DenpaMenResistanceCacheInput, DenpaMenResistanceCacheOutput>(
        cuid,
        inputFromJson: DenpaMenResistanceCacheInput.fromJson,
        outputFromJson: DenpaMenResistanceCacheOutput.fromJson,
      );
  return cached?.output.resistances;
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
