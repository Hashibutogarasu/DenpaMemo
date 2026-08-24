import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:denpa_memo/data/objectbox/objectbox.dart';
import '../support/test_app.dart';

void main() {
  testWidgets(
    'adding via the QR-code flow already links the new individual to the '
    'session\'s QR code, and the QR code field is disabled',
    (WidgetTester tester) async {
      final objectBox = ObjectBox.createInMemory();
      addTearDown(objectBox.store.close);
      await tester.pumpWidget(TestApp(objectBox: objectBox));
      await tester.pumpAndSettle();

      await tester.tap(find.byIcon(Icons.add));
      await tester.pumpAndSettle();

      await tester.tap(find.text('QRコードから追加'));
      await tester.pumpAndSettle();

      await tester.tap(find.text('次へ'));
      await tester.pumpAndSettle();

      final qrCodeTile = find.widgetWithText(InkWell, 'QRコード');
      await tester.dragUntilVisible(
        qrCodeTile,
        find.byType(Scrollable).first,
        const Offset(0, -80),
      );

      expect(
        find.descendant(of: qrCodeTile, matching: find.text('未設定')),
        findsNothing,
      );

      await tester.tap(qrCodeTile);
      await tester.pumpAndSettle();

      expect(find.text('決定'), findsNothing);
    },
  );
}
