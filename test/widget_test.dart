import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:denpa_memo/data/objectbox/objectbox.dart';
import 'package:denpa_memo/main.dart';

void main() {
  testWidgets('MyApp builds', (WidgetTester tester) async {
    await tester.pumpWidget(MyApp(objectBox: ObjectBox.createInMemory()));

    expect(find.byType(Scaffold), findsNWidgets(2));
  });
}
