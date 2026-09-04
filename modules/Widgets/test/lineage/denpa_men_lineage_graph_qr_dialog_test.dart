import 'package:data_pack/data_pack.dart';
import 'package:denpamemo_widgets/denpamemo_widgets.dart';
import 'package:denpamemo_widgets/testing.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:qr_flutter/qr_flutter.dart';

Widget _harness({
  required List<QrCodeRecord> qrCodes,
}) {
  return TestApp(
    home: Scaffold(
      body: DenpaMenLineageGraph(
        qrCodes: qrCodes,
        denpaMenRecords: const [],
        selectionMode: false,
        selectedIds: const {},
        onToggleSelection: (_) {},
        onMiddleClickSelect: (_) {},
        onTapNode: (context, denpaMen) {},
      ),
    ),
  );
}

void main() {
  testWidgets(
    'tapping a QR code node shows a large QR dialog; closing the dialog '
    'shows the tree node again',
    (WidgetTester tester) async {
      final qrCode = createQrCode('raw-value', id: 'qr-1', name: 'group');

      await tester.pumpWidget(
        _harness(qrCodes: [QrCodeRecord(id: 1, qrCode: qrCode)]),
      );
      await tester.pumpAndSettle();

      expect(find.byType(QrCodeNode), findsOneWidget);
      expect(find.byType(QrImageView), findsOneWidget);
      final treeSize = tester.widget<QrImageView>(find.byType(QrImageView)).size!;

      await tester.tap(find.byType(QrCodeNode));
      await tester.pumpAndSettle();

      expect(find.byType(QrCodeNode), findsNothing);
      expect(find.byType(QrImageView), findsOneWidget);
      final dialogSize = tester
          .widget<QrImageView>(find.byType(QrImageView))
          .size!;
      expect(dialogSize, greaterThan(treeSize));

      await tester.tapAt(const Offset(10, 10));
      await tester.pumpAndSettle();

      expect(find.byType(QrCodeNode), findsOneWidget);
      final restoredSize = tester
          .widget<QrImageView>(find.byType(QrImageView))
          .size!;
      expect(restoredSize, treeSize);
    },
  );

  testWidgets(
    'while the QR dialog is open, every QR code node in the tree is '
    'hidden, not just the one that was tapped',
    (WidgetTester tester) async {
      final qrCode1 = createQrCode('raw-value-1', id: 'qr-1', name: 'group1');
      final qrCode2 = createQrCode('raw-value-2', id: 'qr-2', name: 'group2');

      await tester.pumpWidget(
        _harness(
          qrCodes: [
            QrCodeRecord(id: 1, qrCode: qrCode1),
            QrCodeRecord(id: 2, qrCode: qrCode2),
          ],
        ),
      );
      await tester.pumpAndSettle();

      expect(find.byType(QrCodeNode), findsNWidgets(2));

      await tester.tap(find.byType(QrCodeNode).first);
      await tester.pumpAndSettle();

      expect(find.byType(QrCodeNode), findsNothing);

      await tester.tapAt(const Offset(10, 10));
      await tester.pumpAndSettle();

      expect(find.byType(QrCodeNode), findsNWidgets(2));
    },
  );
}
