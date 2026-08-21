import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:denpa_memo/domain/backup/dm_import_error.dart';
import 'package:denpa_memo/i18n/gen/strings.g.dart';
import 'package:denpa_memo/widgets/dialog/error_dialog.dart';

void main() {
  Future<void> pumpAndShow(WidgetTester tester, DmImportError error) async {
    await tester.pumpWidget(
      TranslationProvider(
        child: MaterialApp(
          home: Builder(
            builder: (context) => ElevatedButton(
              onPressed: () => ErrorDialog.show(context, error: error),
              child: const Text('open'),
            ),
          ),
        ),
      ),
    );
    await tester.tap(find.text('open'));
    await tester.pumpAndSettle();
  }

  testWidgets('shows the header error title/description centered', (tester) async {
    const error = DmHeaderReadError();
    await pumpAndShow(tester, error);

    final t = Translations();
    expect(find.text(error.title(t)), findsOneWidget);
    expect(find.text(error.description(t)), findsOneWidget);

    final titleText = tester.widget<Text>(find.text(error.title(t)));
    expect(titleText.textAlign, TextAlign.center);
  });

  testWidgets('shows the entry parse error title/description', (tester) async {
    final error = DenpaMenEntryParseError(index: 0, rawEntry: 'broken');
    await pumpAndShow(tester, error);

    final t = Translations();
    expect(find.text(error.title(t)), findsOneWidget);
    expect(find.text(error.description(t)), findsOneWidget);
  });

  testWidgets('OK button closes the dialog', (tester) async {
    const error = DmHeaderReadError();
    await pumpAndShow(tester, error);

    final t = Translations();
    expect(find.text(t.common.ok), findsOneWidget);

    await tester.tap(find.text(t.common.ok));
    await tester.pumpAndSettle();

    expect(find.byType(ErrorDialog), findsNothing);
  });
}
