import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:denpa_memo/i18n/gen/strings.g.dart';
import 'package:denpa_memo/widgets/color/color_dot.dart';
import 'package:denpa_memo/widgets/dialog/body_color_selection_dialog.dart';

BodyColorSelectionResult? _result;

Future<void> _pumpDialog(
  WidgetTester tester, {
  List<String> selected = const [],
  List<int> shades = const [],
  bool isSpColor = false,
}) async {
  await tester.pumpWidget(
    TranslationProvider(
      child: MaterialApp(
        home: Scaffold(
          body: Builder(
            builder: (context) => ElevatedButton(
              onPressed: () async {
                _result = await showBodyColorSelectionDialog(
                  context,
                  selected: selected,
                  shades: shades,
                  isSpColor: isSpColor,
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

Finder _swatch(String colorId) => find.byKey(ValueKey(colorId));

Finder _tile(int index) => find.byKey(ValueKey(index));

Finder _checkIn(Finder swatch) =>
    find.descendant(of: swatch, matching: find.byIcon(Icons.check));

Finder _leadingIconOf(Finder tile) =>
    find.descendant(of: tile, matching: find.byType(ColorDot));

void main() {
  testWidgets(
    'selecting a color adds a shade list tile below the SP switch',
    (WidgetTester tester) async {
      await _pumpDialog(tester);

      expect(find.byType(Slider), findsNothing);

      await tester.tap(_swatch('red'));
      await tester.pumpAndSettle();

      expect(find.byType(Slider), findsOneWidget);
    },
  );

  testWidgets(
    'adjusting the shade slider changes the resolved shade and its label',
    (WidgetTester tester) async {
      await _pumpDialog(tester);

      await tester.tap(_swatch('red'));
      await tester.pumpAndSettle();

      final slider = tester.widget<Slider>(find.byType(Slider));
      expect(slider.value, 0);

      slider.onChanged!(-1);
      await tester.pumpAndSettle();

      final shadedSlider = tester.widget<Slider>(find.byType(Slider));
      expect(shadedSlider.value, -1);
    },
  );

  testWidgets(
    'adjusting a tile\'s shade off 0 unchecks its swatch, and tapping the '
    'swatch again adds a second entry rather than removing the first, so '
    'the same color can be selected twice at different shades',
    (WidgetTester tester) async {
      await _pumpDialog(tester);

      await tester.tap(_swatch('red'));
      await tester.pumpAndSettle();
      expect(_checkIn(_swatch('red')), findsOneWidget);

      final firstSlider = tester.widget<Slider>(find.byType(Slider));
      firstSlider.onChanged!(-1);
      await tester.pumpAndSettle();
      expect(_checkIn(_swatch('red')), findsNothing);

      await tester.tap(_swatch('red'));
      await tester.pumpAndSettle();

      expect(find.byType(Slider), findsNWidgets(2));

      await tester.tap(find.text('決定'));
      await tester.pumpAndSettle();

      expect(_result?.bodyColors, ['red', 'red']);
      expect(_result?.bodyColorShades, [-1, 0]);
    },
  );

  testWidgets(
    'a list tile only shows the shaded color icon and the shade slider',
    (WidgetTester tester) async {
      await _pumpDialog(tester);

      await tester.tap(_swatch('red'));
      await tester.pumpAndSettle();

      expect(find.descendant(of: _tile(0), matching: find.byType(Text)), findsNothing);
      expect(_leadingIconOf(_tile(0)), findsOneWidget);
      expect(find.descendant(of: _tile(0), matching: find.byType(Slider)), findsOneWidget);
    },
  );

  testWidgets(
    'tapping a list tile\'s icon moves the checked swatch to its color',
    (WidgetTester tester) async {
      await _pumpDialog(tester);

      await tester.tap(_swatch('red'));
      await tester.pumpAndSettle();
      await tester.tap(_swatch('blue'));
      await tester.pumpAndSettle();

      expect(_checkIn(_swatch('blue')), findsOneWidget);
      expect(_checkIn(_swatch('red')), findsNothing);

      final firstTileIcon = _leadingIconOf(_tile(0));
      await tester.ensureVisible(firstTileIcon);
      await tester.tap(firstTileIcon);
      await tester.pumpAndSettle();

      expect(_checkIn(_swatch('red')), findsOneWidget);
      expect(_checkIn(_swatch('blue')), findsNothing);
    },
  );
}
