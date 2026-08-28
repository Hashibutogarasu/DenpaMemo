import 'package:data_pack/data_pack.dart';
import 'package:denpamemo_widgets/denpamemo_widgets.dart' hide BuildContextTranslationsExtension;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';

import 'package:denpa_memo/pages/home.dart';
import 'package:denpa_memo/providers/denpa_men_icon_providers.dart';
import 'package:denpa_memo/providers/denpa_men_providers.dart';
import 'package:denpa_memo/widgets/selection_floating_menu.dart';
import 'package:graphql_client/graphql_client.dart';
import '../support/all_translation_providers.dart';

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

  final record = DenpaMenRecord(
    id: 1,
    denpaMen: createDenpaMen(
      name: 'responsive-list-individual',
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
    ),
  );

  Future<void> pumpAtWidth(WidgetTester tester, double width) async {
    tester.view.physicalSize = Size(width, 1200);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    final router = GoRouter(
      initialLocation: '/',
      routes: [GoRoute(path: '/', builder: (context, state) => const Home())],
    );
    addTearDown(router.dispose);

    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          denpaMenIconProvider.overrideWith((ref, id) async => null),
          masterDataProvider.overrideWithValue(AsyncData(masterData)),
          denpaMenListProvider.overrideWith(
            (ref, masterData) => Stream.value([record]),
          ),
        ],
        child: AllTranslationProviders(
          child: MaterialApp.router(routerConfig: router),
        ),
      ),
    );
    await tester.pump();
    await tester.pump();
  }

  testWidgets('uses DenpaMenListTile instead of DenpaMenAccordionTile at '
      'mobile widths, keeping SelectionFloatingMenu unchanged', (
    tester,
  ) async {
    await pumpAtWidth(tester, 400);

    expect(find.byType(DenpaMenListTile), findsOneWidget);
    expect(find.byType(DenpaMenAccordionTile), findsNothing);
    expect(find.byType(SelectionFloatingMenu), findsOneWidget);
  });

  testWidgets('uses DenpaMenAccordionTile at desktop widths', (tester) async {
    await pumpAtWidth(tester, 1000);

    expect(find.byType(DenpaMenAccordionTile), findsOneWidget);
    expect(find.byType(DenpaMenListTile), findsNothing);
    expect(find.byType(SelectionFloatingMenu), findsOneWidget);
  });
}
