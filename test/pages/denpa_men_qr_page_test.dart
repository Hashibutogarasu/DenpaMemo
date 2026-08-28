import 'package:data_pack/data_pack.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:qr_flutter/qr_flutter.dart';

import 'package:denpa_memo/i18n/gen/strings.g.dart';
import 'package:denpa_memo/pages/denpa_men_qr.dart';
import 'package:denpa_memo/providers/denpa_men_session_providers.dart';

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
            builder: (context, state) => DenpaMenQrPage(
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
            child: MaterialApp.router(routerConfig: router),
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
