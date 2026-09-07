import 'package:flutter/material.dart';

import 'package:flutter_test/flutter_test.dart';

import 'package:denpamemo_widgets/denpamemo_widgets.dart';
import 'package:denpamemo_widgets/testing.dart';

void main() {
  testWidgets(
    'onLongPress fires even when onTap is not set (e.g. a tile that is '
    'only long-pressable and has a trailing action menu)',
    (tester) async {
      var longPressed = false;
      await tester.pumpWidget(
        TestApp(
          home: Scaffold(
            body: ListItemTile(
              icon: Icons.description_outlined,
              label: 'backup.dm',
              onLongPress: () => longPressed = true,
            ),
          ),
        ),
      );

      await tester.longPress(find.byType(ListItemTile));
      await tester.pumpAndSettle();

      expect(longPressed, isTrue);
    },
  );
}
