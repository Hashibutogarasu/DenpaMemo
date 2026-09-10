import 'package:denpamemo_widgets/denpamemo_widgets.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  Future<void> pumpContainer(WidgetTester tester, Widget child) {
    return tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: SizedBox(
            height: 400,
            child: SmoothScrollContainer(child: child),
          ),
        ),
      ),
    );
  }

  Future<void> mouseScroll(WidgetTester tester, Finder over) async {
    final pointer = TestPointer(1, PointerDeviceKind.mouse);
    await tester.sendEventToBinding(
      pointer.addPointer(location: tester.getCenter(over)),
    );
    await tester.sendEventToBinding(pointer.scroll(const Offset(0, 300)));
  }

  testWidgets(
    'mouse-wheel scrolling over a non-scrollable child crashes the shared '
    'controller',
    (tester) async {
      await pumpContainer(
        tester,
        const ColoredBox(
          color: Colors.transparent,
          child: Center(child: Text('empty')),
        ),
      );
      await tester.pump(const Duration(milliseconds: 1));

      await mouseScroll(tester, find.byType(SmoothScrollContainer));
      await tester.pump();

      final exception = tester.takeException();
      expect(exception, isA<AssertionError>());
      expect(
        exception.toString(),
        contains('not attached to any scroll views'),
      );
    },
  );

  testWidgets('ScrollableFiller keeps the shared controller attached during a '
      'mouse-wheel scroll', (tester) async {
    await pumpContainer(
      tester,
      const ScrollableFiller(child: Center(child: Text('empty'))),
    );
    await tester.pump(const Duration(milliseconds: 1));

    await mouseScroll(tester, find.byType(SmoothScrollContainer));
    await tester.pump();

    expect(tester.takeException(), isNull);

    await tester.pump(const Duration(seconds: 3));
  });
}
