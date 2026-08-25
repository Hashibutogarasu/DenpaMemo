import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:denpa_memo/widgetbook/core/dialog_preview.dart';
import 'package:denpa_memo/widgetbook/core/widgetbook_scope.dart';
import 'package:denpa_memo/widgetbook/denpa_men/route_denpa_men_data.dart';
import 'package:denpa_memo/widgets/dialog/body_color_selection_dialog.dart';

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
