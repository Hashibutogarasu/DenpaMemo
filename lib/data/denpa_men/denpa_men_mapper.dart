import '../../domain/denpa_men/denpa_men.dart';
import '../../domain/denpa_men/denpa_men_factory.dart';
import '../../domain/master_data/master_data.dart';
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
      parentIds: parentIds,
      isSpColor: isSpColor,
      headShapeId: headShape.id,
      physiqueId: physique.id,
      personalityId: personality.id,
      patternId: pattern.id,
      anntenaId: anntena.id,
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
    return createDenpaMen(
      id: cuid,
      name: name,
      bodyColors: bodyColors,
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
    );
  }
}
