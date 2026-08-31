import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:denpa_memo/i18n/gen/strings.g.dart';
import 'package:step_dialog/step_dialog.dart' as step_dialog
    hide BuildContextTranslationsExtension;

void main() {
  Future<void> pumpAndShow(
    WidgetTester tester, {
    required String title,
    required String description,
    bool retriable = false,
    Future<void> Function()? onRetry,
  }) async {
    await tester.pumpWidget(
      step_dialog.TranslationProvider(
        child: TranslationProvider(
          child: MaterialApp(
            home: Builder(
              builder: (context) => ElevatedButton(
                onPressed: () => step_dialog.ErrorDialog.show(
                  context,
                  title: title,
                  description: description,
                  retriable: retriable,
                  onRetry: onRetry,
                ),
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

  testWidgets('shows the title/description centered', (tester) async {
    await pumpAndShow(tester, title: 'Some title', description: 'Some description');

    expect(find.text('Some title'), findsOneWidget);
    expect(find.text('Some description'), findsOneWidget);

    final titleText = tester.widget<Text>(find.text('Some title'));
    expect(titleText.textAlign, TextAlign.center);
  });

  testWidgets('OK button closes the dialog', (tester) async {
    await pumpAndShow(tester, title: 'Some title', description: 'Some description');

    final t = Translations();
    expect(find.text(t.common.ok), findsOneWidget);

    await tester.tap(find.text(t.common.ok));
    await tester.pumpAndSettle();

    expect(find.byType(step_dialog.ErrorDialog), findsNothing);
  });
}
