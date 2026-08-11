import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:denpa_memo/domain/master_data/master_data.dart';
import 'package:denpa_memo/i18n/gen/strings.g.dart';
import 'package:denpa_memo/widgets/add_denpa_men_fab.dart';

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
    'expanding the add button reveals an option to add from a QR code file',
    (WidgetTester tester) async {
      await tester.pumpWidget(
        TranslationProvider(
          child: MaterialApp(
            home: Scaffold(
              floatingActionButton: AddDenpaMenFab(masterData: _masterData),
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();

      await tester.tap(find.byIcon(Icons.add));
      await tester.pumpAndSettle();

      expect(find.text('QRコードファイルから追加'), findsOneWidget);
    },
  );
}
