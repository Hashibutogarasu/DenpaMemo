import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:denpa_memo/data/objectbox/objectbox.dart';
import 'support/test_app.dart';

void main() {
  testWidgets('MyApp builds', (WidgetTester tester) async {
    await tester.pumpWidget(TestApp(objectBox: ObjectBox.createInMemory()));

    expect(find.byType(Scaffold), findsNWidgets(2));
  });
}
