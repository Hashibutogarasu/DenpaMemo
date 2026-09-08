import 'package:data_pack/data_pack.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:denpa_memo/i18n/gen/strings.g.dart';
import 'package:denpa_memo/theme/app_theme.dart';
import 'package:denpa_memo/widgets/add_denpa_men_fab.dart';

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
    'expanding the add button reveals an option to add from a QR code file',
    (WidgetTester tester) async {
      await tester.pumpWidget(
        TranslationProvider(
          child: MaterialApp(
            theme: AppLightTheme.forContrast(AppContrastLevel.standard),
            home: const Scaffold(
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

  testWidgets(
    'with onImport/onExport both null, only the original 4 options appear',
    (WidgetTester tester) async {
      await tester.pumpWidget(
        TranslationProvider(
          child: MaterialApp(
            theme: AppLightTheme.forContrast(AppContrastLevel.standard),
            home: const Scaffold(
              floatingActionButton: AddDenpaMenFab(masterData: _masterData),
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();

      await tester.tap(find.byIcon(Icons.add));
      await tester.pumpAndSettle();

      expect(find.text('インポート'), findsNothing);
      expect(find.text('選択項目をエクスポート'), findsNothing);
    },
  );

  testWidgets('onImport adds an import option that invokes the callback', (
    WidgetTester tester,
  ) async {
    var imported = false;
    await tester.pumpWidget(
      TranslationProvider(
        child: MaterialApp(
          theme: AppLightTheme.forContrast(AppContrastLevel.standard),
          home: Scaffold(
            floatingActionButton: AddDenpaMenFab(
              masterData: _masterData,
              onImport: () => imported = true,
            ),
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();

    await tester.tap(find.byIcon(Icons.add));
    await tester.pumpAndSettle();

    expect(find.text('インポート'), findsOneWidget);
    await tester.tap(find.text('インポート'));
    await tester.pumpAndSettle();

    expect(imported, isTrue);
  });

  testWidgets('onExport adds an export option that invokes the callback', (
    WidgetTester tester,
  ) async {
    var exported = false;
    await tester.pumpWidget(
      TranslationProvider(
        child: MaterialApp(
          theme: AppLightTheme.forContrast(AppContrastLevel.standard),
          home: Scaffold(
            floatingActionButton: AddDenpaMenFab(
              masterData: _masterData,
              onExport: () => exported = true,
            ),
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();

    await tester.tap(find.byIcon(Icons.add));
    await tester.pumpAndSettle();

    expect(find.text('選択項目をエクスポート'), findsOneWidget);
    await tester.tap(find.text('選択項目をエクスポート'));
    await tester.pumpAndSettle();

    expect(exported, isTrue);
  });
}
