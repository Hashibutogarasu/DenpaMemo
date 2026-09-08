import 'package:data_pack/data_pack.dart';
import 'package:denpamemo_widgets/denpamemo_widgets.dart'
    hide BuildContextTranslationsExtension;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';

import 'package:denpa_memo/pages/home.dart';
import 'package:denpa_memo/providers/denpa_men_providers.dart';
import 'package:denpa_memo/theme/app_theme.dart';
import 'package:graphql_client/graphql_client.dart';
import '../support/all_translation_providers.dart';

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

void main() {
  Finder findAppBarOverflowMenu() => find.descendant(
    of: find.byType(SlantedAppBar),
    matching: find.byIcon(Icons.more_vert),
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
          masterDataProvider.overrideWithValue(const AsyncData(_masterData)),
          denpaMenListProvider.overrideWith(
            (ref, masterData) => Stream.value(const <DenpaMenRecord>[]),
          ),
        ],
        child: AllTranslationProviders(
          child: MaterialApp.router(
            theme: AppLightTheme.forContrast(AppContrastLevel.standard),
            routerConfig: router,
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();
  }

  testWidgets(
    'hides the AppBar overflow menu and keeps the title from overflowing '
    'at mobile widths',
    (tester) async {
      await pumpAtWidth(tester, 400);

      expect(findAppBarOverflowMenu(), findsNothing);
      expect(tester.takeException(), isNull);
    },
  );

  testWidgets('shows the AppBar overflow menu at desktop widths', (
    tester,
  ) async {
    await pumpAtWidth(tester, 1000);

    expect(findAppBarOverflowMenu(), findsOneWidget);
  });
}
