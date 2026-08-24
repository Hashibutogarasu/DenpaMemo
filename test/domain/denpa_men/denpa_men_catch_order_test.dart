import 'package:denpa_memo/domain/denpa_men/denpa_men.dart';
import 'package:denpa_memo/domain/denpa_men/denpa_men_catch_order.dart';
import 'package:denpa_memo/domain/master_data/anntena.dart';
import 'package:denpa_memo/domain/master_data/head_shape.dart';
import 'package:denpa_memo/domain/master_data/pattern.dart';
import 'package:denpa_memo/domain/master_data/personality.dart';
import 'package:denpa_memo/domain/master_data/physique.dart';
import 'package:flutter_test/flutter_test.dart';

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

void main() {
  test('a caught individual returns its own catchOrder', () {
    final caught = _denpaMen(id: 'a', catchOrder: 3);

    expect(caught.newCatchOrder({'a': caught}), 3);
  });

  test('a bred individual resolves the last parent\'s catchOrder', () {
    final parentA = _denpaMen(id: 'a', catchOrder: 3);
    final parentB = _denpaMen(id: 'b', catchOrder: 5);
    final child = _denpaMen(id: 'c', parentIds: ['a', 'b']);
    final byId = {'a': parentA, 'b': parentB, 'c': child};

    expect(child.newCatchOrder(byId), 5);
  });

  test('a grandchild resolves through multiple generations', () {
    final otherParent = _denpaMen(id: 'a', catchOrder: 7);
    final ancestor = _denpaMen(id: 'b', catchOrder: 9);
    final parent = _denpaMen(id: 'c', parentIds: ['a', 'b']);
    final otherGrandparent = _denpaMen(id: 'd', catchOrder: 11);
    final grandchild = _denpaMen(id: 'e', parentIds: ['d', 'c']);
    final byId = {
      'a': otherParent,
      'b': ancestor,
      'c': parent,
      'd': otherGrandparent,
      'e': grandchild,
    };

    expect(grandchild.newCatchOrder(byId), 9);
  });

  test('returns null when the last parent is missing', () {
    final child = _denpaMen(id: 'c', parentIds: ['a', 'missing']);

    expect(child.newCatchOrder({'c': child}), isNull);
  });

  test('returns null instead of looping on a cycle', () {
    final a = _denpaMen(id: 'a', parentIds: ['x', 'b']);
    final b = _denpaMen(id: 'b', parentIds: ['y', 'a']);
    final byId = {'a': a, 'b': b};

    expect(a.newCatchOrder(byId), isNull);
  });
}
