import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';

import 'package:denpa_memo/domain/denpa_men/denpa_men_factory.dart';
import 'package:denpa_memo/domain/denpa_men/denpa_men_record.dart';
import 'package:denpa_memo/domain/master_data/anntena.dart';
import 'package:denpa_memo/domain/master_data/attribute.dart';
import 'package:denpa_memo/domain/master_data/body_color_resistance_rule.dart';
import 'package:denpa_memo/domain/master_data/head_shape.dart';
import 'package:denpa_memo/domain/master_data/master_data.dart';
import 'package:denpa_memo/domain/master_data/pattern.dart';
import 'package:denpa_memo/domain/master_data/personality.dart';
import 'package:denpa_memo/domain/master_data/physique.dart';
import 'package:denpa_memo/i18n/gen/strings.g.dart';
import 'package:denpa_memo/pages/home.dart';
import 'package:denpa_memo/providers/denpa_men_icon_providers.dart';
import 'package:denpa_memo/providers/denpa_men_providers.dart';
import 'package:denpa_memo/providers/master_data_providers.dart';
import 'package:denpa_memo/widgets/denpa_men_accordion_tile.dart';
import 'package:denpa_memo/widgets/denpa_men_list_tile.dart';
import 'package:denpa_memo/widgets/selection_floating_menu.dart';

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
        child: TranslationProvider(
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
