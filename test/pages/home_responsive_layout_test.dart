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

final _masterData = MasterData(
  headShapes: const [],
  anntenas: const [],
  attributes: const [],
  abnormalityTypes: const [],
  bodyColorResistanceRules: const [],
  bodyColorAbnormalityResistanceRules: const [],
  physiques: const [],
  personalities: const [],
  patterns: const [],
  corrections: const [],
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
          masterDataProvider.overrideWithValue(AsyncData(_masterData)),
          denpaMenListProvider.overrideWith(
            (ref, masterData) => Stream.value(const <DenpaMenRecord>[]),
          ),
        ],
        child: AllTranslationProviders(
          child: MaterialApp.router(
            theme: AppLightTheme.theme,
            routerConfig: router,
          ),
        ),
      ),
    );
    await tester.pump();
    await tester.pump();
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
