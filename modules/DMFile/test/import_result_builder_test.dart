import 'package:data_pack/data_pack.dart';
import 'package:dm_file/dm_file.dart';
import 'package:flutter_test/flutter_test.dart';

class _InMemoryDenpaMenRepository implements DenpaMenRepository {
  final Map<int, DenpaMen> _records = {};
  int _nextId = 1;

  @override
  List<DenpaMenRecord> getAll(MasterData masterData) => [
    for (final entry in _records.entries)
      DenpaMenRecord(id: entry.key, denpaMen: entry.value),
  ];

  @override
  Stream<List<DenpaMenRecord>> watchAll(MasterData masterData) =>
      Stream.value(getAll(masterData));

  @override
  int save(DenpaMen denpaMen, {int id = 0}) {
    final recordId = id == 0 ? _nextId++ : id;
    _records[recordId] = denpaMen;
    return recordId;
  }

  @override
  DenpaMenRecord? findByCuid(String cuid, MasterData masterData) {
    for (final entry in _records.entries) {
      if (entry.value.id == cuid) {
        return DenpaMenRecord(id: entry.key, denpaMen: entry.value);
      }
    }
    return null;
  }

  @override
  void delete(int id) => _records.remove(id);

  @override
  List<DenpaMenRecord> getChildrens(DenpaMen denpaMen, MasterData masterData) =>
      throw UnimplementedError();
}

void main() {
  final headShape = const HeadShape(id: 'head-a');
  final anntena = const Anntena(id: 'anntena-a', category: AnntenaCategory.other);
  final physique = const Physique(id: 'physique-a');
  final personality = const Personality(id: 'personality-a');
  final pattern = const Pattern(id: 'pattern-a');
  final colorId = 'color-a';

  final masterData = MasterData(
    headShapes: [headShape],
    anntenas: [anntena],
    attributes: const [],
    abnormalityTypes: const [],
    physiques: [physique],
    personalities: [personality],
    patterns: [pattern],
    bodyColorResistanceRules: [
      BodyColorResistanceRule(colorId: colorId, attributeResistanceBonuses: const []),
    ],
    bodyColorAbnormalityResistanceRules: const [],
    corrections: const [],
  );

  test(
    'buildImportResult buckets by outcome and detects orphans across the batch and the DB',
    () {
      final denpaMenRepository = _InMemoryDenpaMenRepository();

      final existingParent = createDenpaMen(
        name: 'existing-parent',
        bodyColors: [colorId],
        isSpColor: false,
        headShape: headShape,
        physique: physique,
        personality: personality,
        pattern: pattern,
        anntena: anntena,
        masterData: masterData,
        maxHappiness: 0,
        maxLevel: 1,
      );
      denpaMenRepository.save(existingParent);

      final batchParent = createDenpaMen(
        name: 'batch-parent',
        bodyColors: [colorId],
        isSpColor: false,
        headShape: headShape,
        physique: physique,
        personality: personality,
        pattern: pattern,
        anntena: anntena,
        masterData: masterData,
        maxHappiness: 0,
        maxLevel: 1,
      );
      denpaMenRepository.save(batchParent);

      final linkedToBoth = createDenpaMen(
        name: 'linked-to-both',
        bodyColors: [colorId],
        isSpColor: false,
        headShape: headShape,
        physique: physique,
        personality: personality,
        pattern: pattern,
        anntena: anntena,
        masterData: masterData,
        maxHappiness: 0,
        maxLevel: 1,
        parentIds: [existingParent.id, batchParent.id],
      );
      final orphan = createDenpaMen(
        name: 'orphan',
        bodyColors: [colorId],
        isSpColor: false,
        headShape: headShape,
        physique: physique,
        personality: personality,
        pattern: pattern,
        anntena: anntena,
        masterData: masterData,
        maxHappiness: 0,
        maxLevel: 1,
        parentIds: ['missing-a', 'missing-b'],
      );
      final noParents = createDenpaMen(
        name: 'no-parents',
        bodyColors: [colorId],
        isSpColor: false,
        headShape: headShape,
        physique: physique,
        personality: personality,
        pattern: pattern,
        anntena: anntena,
        masterData: masterData,
        maxHappiness: 0,
        maxLevel: 1,
      );

      final mergeResults = [
        DenpaMenMergeResult(
          denpaMen: batchParent,
          outcome: DenpaMenMergeOutcome.merged,
        ),
        DenpaMenMergeResult(
          denpaMen: linkedToBoth,
          outcome: DenpaMenMergeOutcome.added,
        ),
        DenpaMenMergeResult(
          denpaMen: orphan,
          outcome: DenpaMenMergeOutcome.added,
        ),
        DenpaMenMergeResult(
          denpaMen: noParents,
          outcome: DenpaMenMergeOutcome.added,
        ),
      ];

      final result = buildImportResult(
        mergeResults,
        const [],
        repository: denpaMenRepository,
        masterData: masterData,
      );

      expect(result.merged.map((d) => d.id), [batchParent.id]);
      expect(
        result.added.map((d) => d.id).toSet(),
        {linkedToBoth.id, orphan.id, noParents.id},
      );
      expect(result.orphaned.map((d) => d.id).toSet(), {orphan.id});
      expect(result.failed, isEmpty);
    },
  );
}
