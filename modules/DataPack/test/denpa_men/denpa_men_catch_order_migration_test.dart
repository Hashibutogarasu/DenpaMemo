import 'package:data_pack/data_pack.dart';
import 'package:test/test.dart';

const _masterData = MasterData(
  headShapes: [],
  anntenas: [],
  attributes: [],
  abnormalityTypes: [],
  bodyColorResistanceRules: [],
  bodyColorAbnormalityResistanceRules: [],
  physiques: [],
  personalities: [],
  patterns: [],
  corrections: [],
);

DenpaMen _denpaMen({
  required String id,
  List<String> parentIds = const [],
  int? catchOrder,
}) {
  return DenpaMen(
    id: id,
    name: id,
    abnormalityResistances: const [],
    bodyColors: const ['color'],
    attributeResistance: const [],
    physique: const Physique(id: 'physique'),
    personality: const Personality(id: 'personality'),
    pattern: const Pattern(id: 'pattern'),
    headShape: const HeadShape(id: 'head', abnormalityResistanceBonuses: {}),
    anntena: const Anntena(id: 'anntena', category: AnntenaCategory.other),
    isSpColor: false,
    happiness: 0,
    maxHappiness: 0,
    level: 1,
    maxLevel: 1,
    currentExp: null,
    maxExp: null,
    hp: 0,
    ap: 0,
    attack: 0,
    defense: 0,
    speed: 0,
    evasionRate: 0,
    corrections: const [],
    considerCorrections: false,
    parentIds: parentIds,
    catchOrder: catchOrder,
  );
}

/// In-memory [DenpaMenRepository] whose [getAll] preserves insertion order,
/// standing in for the capture order [migrateDenpaMenCatchOrders] numbers
/// direct catches against.
class _FakeRepository implements DenpaMenRepository {
  _FakeRepository(List<DenpaMen> denpaMens)
    : records = [
        for (final (index, denpaMen) in denpaMens.indexed)
          DenpaMenRecord(id: index + 1, denpaMen: denpaMen),
      ];

  final List<DenpaMenRecord> records;
  int saveCount = 0;

  @override
  List<DenpaMenRecord> getAll(MasterData masterData) => List.of(records);

  @override
  List<DenpaMenRecord> getRange(
    MasterData masterData, {
    required int offset,
    required int limit,
  }) => records.skip(offset).take(limit).toList();

  @override
  Stream<List<DenpaMenRecord>> watchAll(MasterData masterData) =>
      Stream.value(getAll(masterData));

  @override
  int save(DenpaMen denpaMen, {int id = 0}) {
    saveCount++;
    final index = records.indexWhere((record) => record.id == id);
    if (index == -1) {
      records.add(DenpaMenRecord(id: records.length + 1, denpaMen: denpaMen));
      return records.last.id;
    }
    records[index] = DenpaMenRecord(id: id, denpaMen: denpaMen);
    return id;
  }

  @override
  DenpaMenRecord? findByCuid(String cuid, MasterData masterData) {
    for (final record in records) {
      if (record.denpaMen.id == cuid) {
        return record;
      }
    }
    return null;
  }

  @override
  void delete(int id) => records.removeWhere((record) => record.id == id);

  @override
  List<DenpaMenRecord> getChildrens(DenpaMen denpaMen, MasterData masterData) =>
      [
        for (final record in records)
          if (record.denpaMen.parentIds.contains(denpaMen.id)) record,
      ];
}

Map<String, int?> _ordersOf(_FakeRepository repository) => {
  for (final record in repository.getAll(_masterData))
    record.denpaMen.id: record.denpaMen.catchOrder,
};

void main() {
  test('renumbers direct catches and denormalizes every bred order', () {
    final repository = _FakeRepository([
      _denpaMen(id: 'b', catchOrder: 3),
      _denpaMen(id: 'a', catchOrder: 7),
      _denpaMen(id: 'c', parentIds: ['a', 'b']),
      _denpaMen(id: 'e'),
      _denpaMen(id: 'd', parentIds: ['c', 'e']),
    ]);

    migrateDenpaMenCatchOrders(repository, _masterData);

    expect(_ordersOf(repository), {'b': 0, 'a': 1, 'c': 1, 'e': 2, 'd': 2});
  });

  test('writes nothing when every stored order is already correct', () {
    final repository = _FakeRepository([
      _denpaMen(id: 'a', catchOrder: 0),
      _denpaMen(id: 'b', catchOrder: 1),
      _denpaMen(id: 'c', parentIds: ['a', 'b'], catchOrder: 1),
    ]);

    migrateDenpaMenCatchOrders(repository, _masterData);

    expect(repository.saveCount, 0);
    expect(_ordersOf(repository), {'a': 0, 'b': 1, 'c': 1});
  });

  test('leaves a bred individual null when no ancestor is resolvable', () {
    final repository = _FakeRepository([
      _denpaMen(id: 'c', parentIds: ['missing-a', 'missing-b']),
    ]);

    migrateDenpaMenCatchOrders(repository, _masterData);

    expect(_ordersOf(repository), {'c': isNull});
  });
}
