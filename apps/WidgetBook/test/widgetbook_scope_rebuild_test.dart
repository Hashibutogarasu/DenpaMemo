import 'package:denpamemo_widgets/testing.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:widgetbook_app/core/widgetbook_scope.dart';

/// [widgetbookScope] is a plain function, invoked fresh every time its
/// caller (part of Widgetbook's own widget tree) rebuilds — not a widget
/// with its own persistent State. If it built a brand new router config on
/// every call, [MaterialApp.router] would tear down and reinitialize its
/// [Router] each time it's rebuilt, which can itself schedule another
/// frame — an infinite rebuild loop with no thrown exception, just a
/// frozen app.
void main() {
  testWidgets(
    'widgetbookScope settles instead of endlessly scheduling frames across rebuilds',
    (tester) async {
      await tester.runAsync(RouteDenpaMenData.initialize);

      Widget build(BuildContext context) =>
          widgetbookScope(context, const Text('content'));

      await tester.pumpWidget(Builder(builder: build));

      expect(tester.takeException(), isNull);
    },
  );
}
