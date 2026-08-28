import 'package:denpamemo_widgets/testing.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:widgetbook_app/core/widgetbook_scope.dart';
import 'package:widgetbook_app/use_cases/denpa_men_list_tile.widgetbook.dart';

void main() {
  testWidgets('DenpaMenListTile Default use case renders', (tester) async {
    await tester.runAsync(RouteDenpaMenData.initialize);

    await tester.pumpWidget(
      Builder(
        builder: (context) =>
            widgetbookScope(context, denpaMenListTileDefaultUseCase(context)),
      ),
    );
    await tester.pumpAndSettle();

    expect(tester.takeException(), isNull);
    expect(find.byType(ListTile), findsOneWidget);
  });
}
