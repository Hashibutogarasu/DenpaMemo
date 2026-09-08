import 'package:data_pack/data_pack.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:qr_flutter/qr_flutter.dart';

import 'package:denpa_memo/i18n/gen/strings.g.dart';
import 'package:denpa_memo/pages/denpa_men_qr.dart';
import 'package:denpa_memo/providers/denpa_men_session_providers.dart';
import 'package:denpa_memo/theme/app_theme.dart';

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
  testWidgets(
    'given an initialRawValue, the session and displayed QR code use it '
    'instead of generating a fresh one',
    (WidgetTester tester) async {
      final container = ProviderContainer();
      addTearDown(container.dispose);

      final router = GoRouter(
        initialLocation: '/',
        routes: [
          GoRoute(
            path: '/',
            builder: (context, state) => const DenpaMenQrPage(
              masterData: _masterData,
              initialRawValue: 'imported-raw-value',
            ),
          ),
        ],
      );

      await tester.pumpWidget(
        UncontrolledProviderScope(
          container: container,
          child: TranslationProvider(
            child: MaterialApp.router(
              theme: AppLightTheme.forContrast(AppContrastLevel.standard),
              routerConfig: router,
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.byType(QrImageView), findsOneWidget);
      expect(find.text('imported-raw-value'), findsWidgets);
      expect(
        container.read(denpaMenSessionProvider)?.cuid,
        'imported-raw-value',
      );
    },
  );
}
