import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:denpa_memo/widgetbook/core/widgetbook_scope.dart';
import 'package:denpa_memo/widgetbook/denpa_men/route_denpa_men_data.dart';
import 'package:denpa_memo/widgetbook/denpa_men/route_denpa_men_seed.dart';
import 'package:denpa_memo/widgets/denpa_men_list_tile.widgetbook.dart';

void main() {
  testWidgets('DenpaMenListTile Default use case renders', (tester) async {
    await tester.runAsync(RouteDenpaMenData.initialize);
    seedRouteDenpaMenIntoObjectBox();

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
