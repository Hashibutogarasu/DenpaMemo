import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:denpa_memo/domain/master_data/anntena.dart';
import 'package:denpa_memo/i18n/gen/strings.g.dart';
import 'package:denpa_memo/widgets/dialog/antenna_selection_dialog.dart';

const _healSolo1 = Anntena(
  id: 'heal_solo_1',
  category: AnntenaCategory.support,
  targetCount: 1,
  maxLevel: 9,
  evolvesToId: 'heal_solo_2',
  variantGroupId: 'heal',
);
const _healSolo2 = Anntena(
  id: 'heal_solo_2',
  category: AnntenaCategory.support,
  targetCount: 1,
  variantGroupId: 'heal',
);
const _healAll1 = Anntena(
  id: 'heal_all_1',
  category: AnntenaCategory.support,
  maxLevel: 9,
  evolvesToId: 'heal_all_2',
  variantGroupId: 'heal',
);
const _healAll2 = Anntena(
  id: 'heal_all_2',
  category: AnntenaCategory.support,
  variantGroupId: 'heal',
);

const _guardAll = Anntena(
  id: 'guard_all',
  category: AnntenaCategory.support,
  variantGroupId: 'guard',
);
const _guard1 = Anntena(
  id: 'guard_1',
  category: AnntenaCategory.support,
  targetCount: 1,
  variantGroupId: 'guard',
);

const _waterGun1 = Anntena(
  id: 'waterGun_1',
  category: AnntenaCategory.attack,
  targetCount: 1,
  dealsDamage: true,
  attackAttributeId: 'water',
  variantGroupId: 'waterGun',
);
const _waterGun3 = Anntena(
  id: 'waterGun_3',
  category: AnntenaCategory.attack,
  targetCount: 3,
  dealsDamage: true,
  attackAttributeId: 'water',
  variantGroupId: 'waterGun',
);
const _waterGunAll = Anntena(
  id: 'waterGun_all',
  category: AnntenaCategory.attack,
  dealsDamage: true,
  attackAttributeId: 'water',
  variantGroupId: 'waterGun',
);

const _allAnntenas = [
  _healSolo1,
  _healSolo2,
  _healAll1,
  _healAll2,
  _guardAll,
  _guard1,
  _waterGun1,
  _waterGun3,
  _waterGunAll,
];

AntennaSelectionResult? _result;

Future<void> _pumpDialog(
  WidgetTester tester, {
  required int level,
  Anntena selected = _healSolo1,
}) async {
  await tester.pumpWidget(
    TranslationProvider(
      child: MaterialApp(
        home: Scaffold(
          body: Builder(
            builder: (context) => ElevatedButton(
              onPressed: () async {
                _result = await showAntennaSelectionDialog(
                  context,
                  anntenas: _allAnntenas,
                  selected: selected,
                  level: level,
                );
              },
              child: const Text('open'),
            ),
          ),
        ),
      ),
    ),
  );
  await tester.tap(find.text('open'));
  await tester.pumpAndSettle();
}

Slider _levelSlider(WidgetTester tester) =>
    tester.widgetList<Slider>(find.byType(Slider)).first;

void main() {
  testWidgets(
    'opens directly on the support tab for a support-category selection, '
    'without having to switch tabs',
    (WidgetTester tester) async {
      await _pumpDialog(tester, level: 3);

      expect(find.text('ちょっとかいふく+3'), findsOneWidget);
    },
  );

  testWidgets(
    'list item shows the +N suffix live and confirms the resolved leaf '
    'and level',
    (WidgetTester tester) async {
      await _pumpDialog(tester, level: 3);

      expect(find.text('ちょっとかいふく+3'), findsOneWidget);

      _levelSlider(tester).onChanged!(9);
      await tester.pumpAndSettle();
      expect(find.text('ちょっとかいふく+9'), findsOneWidget);

      await tester.tap(find.text('決定'));
      await tester.pumpAndSettle();

      expect(_result?.anntena.id, 'heal_solo_1');
      expect(_result?.level, 9);
    },
  );

  testWidgets('level 0 shows no plus suffix', (WidgetTester tester) async {
    await _pumpDialog(tester, level: 0);

    expect(find.text('ちょっとかいふく'), findsOneWidget);
    expect(find.textContaining('+'), findsNothing);
  });

  testWidgets(
    'reopening with a previously saved level restores that level, not 0',
    (WidgetTester tester) async {
      await _pumpDialog(tester, level: 7);

      expect(find.text('ちょっとかいふく+7'), findsOneWidget);
    },
  );

  testWidgets(
    'an unselected family always shows its default pattern (index 0), '
    'even while another family has a non-zero pattern index selected',
    (WidgetTester tester) async {
      await _pumpDialog(tester, level: 0, selected: _healSolo1);

      final patternSlider =
          tester.widgetList<Slider>(find.byType(Slider)).last;
      patternSlider.onChanged!(1);
      await tester.pumpAndSettle();
      expect(find.text('ちょっとかいふく'), findsOneWidget);

      expect(find.text('guard_all'), findsOneWidget);
      expect(find.text('guard_1'), findsNothing);
    },
  );

  testWidgets(
    'selecting a family via its pattern slider confirms that pattern, '
    'not index 0',
    (WidgetTester tester) async {
      await _pumpDialog(tester, level: 0, selected: _healSolo1);

      await tester.tap(find.text('guard_all'));
      await tester.pumpAndSettle();

      final patternSlider =
          tester.widgetList<Slider>(find.byType(Slider)).last;
      patternSlider.onChanged!(1);
      await tester.pumpAndSettle();
      expect(find.text('guard_1'), findsOneWidget);

      await tester.tap(find.text('決定'));
      await tester.pumpAndSettle();

      expect(_result?.anntena.id, 'guard_1');
    },
  );

  testWidgets(
    'an attack antenna with no maxLevel still gets a live +N suffix, '
    'e.g. みずでっぽう+9 / たかなみ+3',
    (WidgetTester tester) async {
      await _pumpDialog(tester, level: 3, selected: _healSolo1);

      await tester.tap(find.text('攻撃'));
      await tester.pumpAndSettle();

      expect(find.text('みずでっぽう+3'), findsOneWidget);

      await tester.tap(find.text('みずでっぽう+3'));
      await tester.pumpAndSettle();

      _levelSlider(tester).onChanged!(9);
      await tester.pumpAndSettle();

      expect(find.text('みずでっぽう+9'), findsOneWidget);

      final patternSlider =
          tester.widgetList<Slider>(find.byType(Slider)).last;
      patternSlider.onChanged!(1);
      await tester.pumpAndSettle();

      expect(find.text('バケツの水+9'), findsOneWidget);

      _levelSlider(tester).onChanged!(3);
      await tester.pumpAndSettle();

      expect(find.text('バケツの水+3'), findsOneWidget);

      await tester.tap(find.text('決定'));
      await tester.pumpAndSettle();

      expect(_result?.anntena.id, 'waterGun_1');
      expect(_result?.level, 3);
    },
  );
}
