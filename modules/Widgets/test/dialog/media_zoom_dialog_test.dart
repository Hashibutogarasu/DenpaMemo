import 'package:denpamemo_widgets/denpamemo_widgets.dart';
import 'package:denpamemo_widgets/testing.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

Widget _page(int index) =>
    Container(key: ValueKey('page-$index'), color: Colors.red);

void main() {
  testWidgets('renders every page passed via itemCount/itemBuilder', (
    tester,
  ) async {
    await tester.pumpWidget(
      TestApp(
        home: MediaZoomDialog(
          itemCount: 3,
          itemBuilder: (context, index) => _page(index),
        ),
      ),
    );

    expect(find.byType(PageView), findsOneWidget);
    expect(find.byKey(const ValueKey('page-0')), findsOneWidget);
  });

  testWidgets('swiping moves to the next page in a multi-page dialog', (
    tester,
  ) async {
    await tester.pumpWidget(
      TestApp(
        home: MediaZoomDialog(
          itemCount: 3,
          itemBuilder: (context, index) => _page(index),
        ),
      ),
    );

    await tester.drag(find.byType(PageView), const Offset(-400, 0));
    await tester.pumpAndSettle();

    expect(find.byKey(const ValueKey('page-0')), findsNothing);
    expect(find.byKey(const ValueKey('page-1')), findsOneWidget);
  });

  testWidgets(
    'a single item renders without a PageView and does not move on swipe',
    (tester) async {
      await tester.pumpWidget(
        TestApp(
          home: MediaZoomDialog(
            itemCount: 1,
            itemBuilder: (context, index) => _page(index),
          ),
        ),
      );

      expect(find.byType(PageView), findsNothing);
      expect(find.byKey(const ValueKey('page-0')), findsOneWidget);
    },
  );
}
