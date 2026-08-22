import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:denpa_memo/data/objectbox/objectbox.dart';
import '../support/test_app.dart';
import 'package:denpa_memo/widgets/color/color_dot.dart';

void main() {
  testWidgets(
    'confirming a body color shade and reopening the dialog restores that '
    'shade instead of resetting it to normal',
    (WidgetTester tester) async {
      final objectBox = ObjectBox.createInMemory();
      await tester.pumpWidget(TestApp(objectBox: objectBox));
      await tester.pumpAndSettle();

      await tester.tap(find.byIcon(Icons.add));
      await tester.pumpAndSettle();

      await tester.tap(find.text('単体で追加'));
      await tester.pumpAndSettle();

      await tester.tap(find.text('体色'));
      await tester.pumpAndSettle();

      final slider = tester.widget<Slider>(find.byType(Slider));
      slider.onChanged!(1);
      await tester.pumpAndSettle();

      await tester.tap(find.text('決定'));
      await tester.pumpAndSettle();

      await tester.tap(find.text('体色'));
      await tester.pumpAndSettle();

      final reopenedSlider = tester.widget<Slider>(find.byType(Slider));
      expect(reopenedSlider.value, 1);

      final dot = tester.widget<ColorDot>(find.byType(ColorDot).last);
      expect(dot.shadeLevel, 1);
    },
  );
}
