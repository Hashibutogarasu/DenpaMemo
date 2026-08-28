import 'package:data_pack/data_pack.dart';

/// Minimal hand-built [MasterData] and sample [DenpaMen] for use in
/// Widgetbook use cases, so they render without a live GraphQL server.
abstract final class DenpaMenData {
  static const anntena = Anntena(id: 'antenna', category: AnntenaCategory.other);
  static const headShape = HeadShape(id: 'head');
  static const physique = Physique(id: 'physique');
  static const personality = Personality(id: 'personality');
  static const pattern = Pattern(id: 'pattern');
  static const colorId = 'color';

  static final masterData = MasterData(
    headShapes: const [headShape],
    anntenas: const [anntena],
    attributes: const [Attribute(id: 'fire', index: 0)],
    abnormalityTypes: const <AbnormalityType>[],
    physiques: const [physique],
    personalities: const [personality],
    patterns: const [pattern],
    bodyColorResistanceRules: const [
      BodyColorResistanceRule(colorId: colorId, attributeResistanceBonuses: []),
    ],
    bodyColorAbnormalityResistanceRules: const [],
    corrections: const [],
  );

  static DenpaMen build(
    String name, {
    String? id,
    int? catchOrder,
    List<String> parentIds = const [],
  }) {
    return createDenpaMen(
      id: id,
      name: name,
      bodyColors: const [colorId],
      isSpColor: false,
      headShape: headShape,
      physique: physique,
      personality: personality,
      pattern: pattern,
      anntena: anntena,
      masterData: masterData,
      maxHappiness: 100,
      happiness: 50,
      level: 5,
      maxLevel: 30,
      hp: 40,
      ap: 30,
      attack: 20,
      defense: 18,
      speed: 12,
      evasionRate: 5,
      catchOrder: catchOrder,
      parentIds: parentIds,
    );
  }

  static final denpaMen = build('こうた', id: 'denpa-1', catchOrder: 1);

  static final denpaMenRecord = DenpaMenRecord(id: 1, denpaMen: denpaMen);
}
