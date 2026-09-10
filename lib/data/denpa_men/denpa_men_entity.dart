import 'package:objectbox/objectbox.dart';

import '../qr_code/qr_code_entity.dart';

/// Persisted representation of a [DenpaMen](../../domain/denpa_men/denpa_men.dart).
///
/// Master data fields ([DenpaMen.headShape], [DenpaMen.physique],
/// [DenpaMen.personality], [DenpaMen.pattern], [DenpaMen.anntena],
/// [DenpaMen.corrections]) are stored as id references rather than embedded
/// objects, so this entity must be resolved against a loaded `MasterData`
/// (see `DenpaMenEntityMapper` in `denpa_men_mapper.dart`) to become a
/// domain [DenpaMen].
@Entity()
class DenpaMenEntity {
  @Id()
  int id;

  String cuid;

  String name;

  List<String> bodyColors;

  List<int> bodyColorShades;

  List<String> parentIds;

  bool isSpColor;

  String headShapeId;

  String physiqueId;

  int? physiqueColumnIndex;

  String personalityId;

  String patternId;

  String anntenaId;

  int antennaLevel;

  int happiness;

  int maxHappiness;

  int level;

  int maxLevel;

  int? currentExp;

  int? maxExp;

  int hp;

  int ap;

  int attack;

  int defense;

  int speed;

  int evasionRate;

  List<String> correctionIds;

  bool considerCorrections;

  int userAddedHpBonus;

  int userAddedApBonus;

  int userAddedAttackBonus;

  int userAddedDefenseBonus;

  int userAddedSpeedBonus;

  int userAddedEvasionRateBonus;

  String userAddedStatBonusName;

  List<String> userAddedAttributeResistanceIds;

  List<int> userAddedAttributeResistanceValues;

  String userAddedAttributeResistanceName;

  List<String> userAddedAbnormalityResistanceIds;

  List<int> userAddedAbnormalityResistanceValues;

  String userAddedAbnormalityResistanceName;

  int? catchOrder;

  String? memo;

  String hash;

  String? monsterExpMonsterId;

  int? monsterExpCount;

  int? monsterExpValue;

  int? monsterExpLevel;

  int? monsterExpMaxLevelTeammateCount;

  int? monsterExpRecipientCount;

  @Property(type: PropertyType.date)
  DateTime createdAt;

  @Property(type: PropertyType.date)
  DateTime? moveInDate;

  final qrCode = ToOne<QrCodeEntity>();

  DenpaMenEntity({
    this.id = 0,
    required this.cuid,
    required this.name,
    required this.bodyColors,
    this.bodyColorShades = const [],
    required this.parentIds,
    required this.isSpColor,
    required this.headShapeId,
    required this.physiqueId,
    this.physiqueColumnIndex,
    required this.personalityId,
    required this.patternId,
    required this.anntenaId,
    this.antennaLevel = 0,
    required this.happiness,
    required this.maxHappiness,
    required this.level,
    required this.maxLevel,
    this.currentExp,
    this.maxExp,
    required this.hp,
    required this.ap,
    required this.attack,
    required this.defense,
    required this.speed,
    required this.evasionRate,
    required this.correctionIds,
    this.considerCorrections = true,
    this.userAddedHpBonus = 0,
    this.userAddedApBonus = 0,
    this.userAddedAttackBonus = 0,
    this.userAddedDefenseBonus = 0,
    this.userAddedSpeedBonus = 0,
    this.userAddedEvasionRateBonus = 0,
    this.userAddedStatBonusName = '',
    this.userAddedAttributeResistanceIds = const [],
    this.userAddedAttributeResistanceValues = const [],
    this.userAddedAttributeResistanceName = '',
    this.userAddedAbnormalityResistanceIds = const [],
    this.userAddedAbnormalityResistanceValues = const [],
    this.userAddedAbnormalityResistanceName = '',
    this.catchOrder,
    this.memo,
    this.hash = '',
    this.monsterExpMonsterId,
    this.monsterExpCount,
    this.monsterExpValue,
    this.monsterExpLevel,
    this.monsterExpMaxLevelTeammateCount,
    this.monsterExpRecipientCount,
    required this.createdAt,
    this.moveInDate,
  });
}
