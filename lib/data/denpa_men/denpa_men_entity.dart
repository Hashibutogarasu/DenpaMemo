import 'package:objectbox/objectbox.dart';

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

  String name;

  List<String> bodyColors;

  bool isSpColor;

  String headShapeId;

  String physiqueId;

  String personalityId;

  String patternId;

  String anntenaId;

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

  String? memo;

  @Property(type: PropertyType.date)
  DateTime createdAt;

  DenpaMenEntity({
    this.id = 0,
    required this.name,
    required this.bodyColors,
    required this.isSpColor,
    required this.headShapeId,
    required this.physiqueId,
    required this.personalityId,
    required this.patternId,
    required this.anntenaId,
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
    this.memo,
    required this.createdAt,
  });
}
