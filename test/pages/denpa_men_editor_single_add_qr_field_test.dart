import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:denpa_memo/data/objectbox/objectbox.dart';
import 'package:denpa_memo/main.dart';

void main() {
  testWidgets(
    'adding a single individual (not via the QR-code flow) leaves the QR '
    'code field unset and tappable',
    (WidgetTester tester) async {
      final objectBox = ObjectBox.createInMemory();
      addTearDown(objectBox.store.close);
      await tester.pumpWidget(MyApp(objectBox: objectBox));
      await tester.pumpAndSettle();

      await tester.tap(find.byIcon(Icons.add));
      await tester.pumpAndSettle();

      await tester.tap(find.text('単体で追加'));
      await tester.pumpAndSettle();

      final qrCodeTile = find.widgetWithText(InkWell, 'QRコード');
      await tester.dragUntilVisible(
        qrCodeTile,
        find.byType(Scrollable).first,
        const Offset(0, -80),
      );

      expect(
        find.descendant(of: qrCodeTile, matching: find.text('未設定')),
        findsOneWidget,
      );

      await tester.tap(qrCodeTile);
      await tester.pumpAndSettle();

      expect(find.text('決定'), findsOneWidget);
    },
  );
}
