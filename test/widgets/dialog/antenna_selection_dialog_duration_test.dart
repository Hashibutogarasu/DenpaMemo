import 'package:data_pack/data_pack.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:denpa_memo/i18n/gen/strings.g.dart';
import 'package:denpa_memo/widgets/dialog/antenna_selection_dialog.dart';

const _exciteSolo1 = Anntena(
  id: 'excite_solo_1',
  category: AnntenaCategory.support,
  targetCount: 1,
  evolvesToId: 'excite_solo_2',
  variantGroupId: 'excite',
);
const _exciteSolo2 = Anntena(
  id: 'excite_solo_2',
  category: AnntenaCategory.support,
  targetCount: 1,
  evolvesToId: 'excite_solo_3',
  variantGroupId: 'excite',
);
const _exciteSolo3 = Anntena(
  id: 'excite_solo_3',
  category: AnntenaCategory.support,
  targetCount: 1,
  variantGroupId: 'excite',
);
const _exciteAll1 = Anntena(
  id: 'excite_all_1',
  category: AnntenaCategory.support,
  targetsAll: true,
  evolvesToId: 'excite_all_2',
  variantGroupId: 'excite',
);
const _exciteAll2 = Anntena(
  id: 'excite_all_2',
  category: AnntenaCategory.support,
  targetsAll: true,
  evolvesToId: 'excite_all_3',
  variantGroupId: 'excite',
);
const _exciteAll3 = Anntena(
  id: 'excite_all_3',
  category: AnntenaCategory.support,
  targetsAll: true,
  variantGroupId: 'excite',
);

const _allAnntenas = [
  _exciteSolo1,
  _exciteSolo2,
  _exciteSolo3,
  _exciteAll1,
  _exciteAll2,
  _exciteAll3,
];

AntennaSelectionResult? _result;

Future<void> _pumpDialog(
  WidgetTester tester, {
  required int level,
  Anntena selected = _exciteSolo1,
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

void main() {
  testWidgets(
    'an antenna with no level (maxLevel null but chained via evolvesToId) '
    'hides the level slider and shows an effect-duration slider instead',
    (WidgetTester tester) async {
      await _pumpDialog(tester, level: 0);

      expect(find.text('すこしこうふん'), findsOneWidget);
      expect(find.text('レベル'), findsNothing);
      expect(find.text('効果時間'), findsOneWidget);
    },
  );

  testWidgets('moving the effect-duration slider cycles すこしこうふん -> こうふん -> '
      'ながくこうふん', (WidgetTester tester) async {
    await _pumpDialog(tester, level: 0);

    final durationSlider = tester.widgetList<Slider>(find.byType(Slider)).first;
    expect(durationSlider.max, 2);

    durationSlider.onChanged!(1);
    await tester.pumpAndSettle();
    expect(find.text('こうふん'), findsOneWidget);

    final updatedSlider = tester.widgetList<Slider>(find.byType(Slider)).first;
    updatedSlider.onChanged!(2);
    await tester.pumpAndSettle();
    expect(find.text('ながくこうふん'), findsOneWidget);

    await tester.tap(find.text('決定'));
    await tester.pumpAndSettle();

    expect(_result?.anntena.id, 'excite_solo_3');
    expect(_result?.level, 0);
  });

  testWidgets(
    'switching to the all-target variant via the effect-range slider keeps '
    'the effect-duration slider working, e.g. みんなすこしこうふん -> '
    'みんなこうふん',
    (WidgetTester tester) async {
      await _pumpDialog(tester, level: 0);

      final rangeSlider = tester.widgetList<Slider>(find.byType(Slider)).last;
      rangeSlider.onChanged!(1);
      await tester.pumpAndSettle();
      expect(find.text('みんなすこしこうふん'), findsOneWidget);

      final durationSlider = tester
          .widgetList<Slider>(find.byType(Slider))
          .first;
      durationSlider.onChanged!(1);
      await tester.pumpAndSettle();
      expect(find.text('みんなこうふん'), findsOneWidget);

      await tester.tap(find.text('決定'));
      await tester.pumpAndSettle();

      expect(_result?.anntena.id, 'excite_all_2');
      expect(_result?.level, 0);
    },
  );
}
