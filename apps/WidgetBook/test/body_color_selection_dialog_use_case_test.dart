import 'package:denpamemo_widgets/denpamemo_widgets.dart';
import 'package:denpamemo_widgets/testing.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:widgetbook_app/core/dialog_preview.dart';
import 'package:widgetbook_app/core/widgetbook_scope.dart';

void main() {
  testWidgets('BodyColorSelectionDialog renders under DialogPreview', (
    tester,
  ) async {
    await tester.runAsync(RouteDenpaMenData.initialize);

    await tester.pumpWidget(
      Builder(
        builder: (context) => widgetbookScope(
          context,
          DialogPreview(
            builder: (context) => const BodyColorSelectionDialog(
              initial: ['red'],
              initialShades: [0],
              initialIsSpColor: false,
            ),
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();

    expect(tester.takeException(), isNull);
    expect(find.byType(BodyColorSelectionDialog), findsOneWidget);
  });
}
