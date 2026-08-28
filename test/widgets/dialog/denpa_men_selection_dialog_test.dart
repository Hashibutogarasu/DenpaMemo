import 'package:data_pack/data_pack.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:denpa_memo/i18n/gen/strings.g.dart';
import 'package:denpa_memo/providers/denpa_men_icon_providers.dart';
import 'package:denpa_memo/widgets/dialog/denpa_men_preview_dialog.dart';
import 'package:denpa_memo/widgets/dialog/denpa_men_selection_dialog.dart';
import 'package:graphql_client/graphql_client.dart';

const _anntena = Anntena(id: 'none', category: AnntenaCategory.other);

void main() {
  final headShape = const HeadShape(id: 'head-a');
  const physique = Physique(id: 'physique-a');
  const personality = Personality(id: 'personality-a');
  const pattern = Pattern(id: 'pattern-a');
  const colorId = 'color-a';

  final masterData = MasterData(
    headShapes: [headShape],
    anntenas: const [_anntena],
    attributes: const [Attribute(id: 'fire', index: 0)],
    abnormalityTypes: const [],
    physiques: const [physique],
    personalities: const [personality],
    patterns: const [pattern],
    bodyColorResistanceRules: const [
      BodyColorResistanceRule(colorId: colorId, attributeResistanceBonuses: []),
    ],
    bodyColorAbnormalityResistanceRules: const [],
    corrections: const [],
  );

  DenpaMen buildDenpaMen(String name) {
    return createDenpaMen(
      name: name,
      bodyColors: const [colorId],
      isSpColor: false,
      headShape: headShape,
      physique: physique,
      personality: personality,
      pattern: pattern,
      anntena: _anntena,
      masterData: masterData,
      maxHappiness: 0,
      maxLevel: 1,
    );
  }

  Future<List<DenpaMen>?> pumpAndShow(
    WidgetTester tester, {
    required List<DenpaMen> candidates,
    List<DenpaMen> initial = const [],
    int minSelection = 1,
  }) async {
    List<DenpaMen>? result;
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          denpaMenIconProvider.overrideWith((ref, id) async => null),
          masterDataProvider.overrideWithValue(AsyncData(masterData)),
        ],
        child: TranslationProvider(
          child: MaterialApp(
            home: Builder(
              builder: (context) => ElevatedButton(
                onPressed: () async {
                  result = await DenpaMenSelectionDialog.show(
                    context,
                    title: 'Select',
                    candidates: candidates,
                    initial: initial,
                    minSelection: minSelection,
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
    return result;
  }

  testWidgets('shows every candidate and toggles selection on tap', (
    WidgetTester tester,
  ) async {
    final a = buildDenpaMen('candidate-a');
    final b = buildDenpaMen('candidate-b');

    await pumpAndShow(tester, candidates: [a, b], initial: const []);

    expect(find.text('candidate-a'), findsOneWidget);
    expect(find.text('candidate-b'), findsOneWidget);

    await tester.tap(find.text('candidate-a'));
    await tester.pumpAndSettle();

    expect(
      tester.widget<ListTile>(find.widgetWithText(ListTile, 'candidate-a')).selected,
      isTrue,
    );
  });

  testWidgets('confirm button is disabled below minSelection', (
    WidgetTester tester,
  ) async {
    final a = buildDenpaMen('candidate-a');

    await pumpAndShow(tester, candidates: [a], initial: const [], minSelection: 1);

    final confirmButton = tester.widget<FilledButton>(find.byType(FilledButton));
    expect(confirmButton.onPressed, isNull);

    await tester.tap(find.text('candidate-a'));
    await tester.pumpAndSettle();

    final confirmButtonAfter = tester.widget<FilledButton>(find.byType(FilledButton));
    expect(confirmButtonAfter.onPressed, isNotNull);
  });

  testWidgets('confirming returns the selected list', (WidgetTester tester) async {
    final a = buildDenpaMen('candidate-a');
    final b = buildDenpaMen('candidate-b');
    List<DenpaMen>? result;

    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          denpaMenIconProvider.overrideWith((ref, id) async => null),
          masterDataProvider.overrideWithValue(AsyncData(masterData)),
        ],
        child: TranslationProvider(
          child: MaterialApp(
            home: Builder(
              builder: (context) => ElevatedButton(
                onPressed: () async {
                  result = await DenpaMenSelectionDialog.show(
                    context,
                    title: 'Select',
                    candidates: [a, b],
                    initial: [a],
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

    await tester.tap(find.byType(FilledButton));
    await tester.pumpAndSettle();

    expect(result, isNotNull);
    expect(result!.map((d) => d.id), [a.id]);
  });

  testWidgets('long press opens the preview dialog', (WidgetTester tester) async {
    final a = buildDenpaMen('candidate-a');

    await pumpAndShow(tester, candidates: [a], initial: const []);

    await tester.longPress(find.text('candidate-a'));
    await tester.pumpAndSettle();

    expect(find.byType(DenpaMenPreviewDialog), findsOneWidget);
  });
}
