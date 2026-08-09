import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:qr_flutter/qr_flutter.dart';

import 'package:denpa_memo/data/objectbox/objectbox.dart';
import 'package:denpa_memo/main.dart';

void main() {
  testWidgets(
    'add flow: QR page -> next -> editor session -> next -> complete '
    'saves both individuals and returns home',
    (WidgetTester tester) async {
      final objectBox = ObjectBox.createInMemory();
      await tester.pumpWidget(MyApp(objectBox: objectBox));
      await tester.pumpAndSettle();

      expect(find.text('電波人間が登録されていません'), findsOneWidget);

      await tester.tap(find.byIcon(Icons.add));
      await tester.pumpAndSettle();

      expect(find.text('次へ'), findsOneWidget);
      expect(find.byType(QrImageView), findsOneWidget);

      await tester.tap(find.text('次へ'));
      await tester.pumpAndSettle();

      expect(find.text('次へ'), findsOneWidget);
      expect(find.text('完了'), findsOneWidget);

      await tester.tap(find.text('次へ'));
      await tester.pumpAndSettle();

      expect(find.text('次へ'), findsOneWidget);
      expect(find.text('完了'), findsOneWidget);

      await tester.tap(find.text('完了'));
      await tester.pumpAndSettle();

      expect(tester.takeException(), isNull);
      expect(objectBox.denpaMenBox.count(), 2);
      expect(objectBox.qrCodeBox.count(), 1);
      expect(find.text('電波人間が登録されていません'), findsNothing);
    },
  );
}
