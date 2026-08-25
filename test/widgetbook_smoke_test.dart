import 'package:denpa_memo/widgetbook.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('WidgetbookApp renders without throwing', (tester) async {
    await tester.pumpWidget(const WidgetbookApp());
    await tester.pumpAndSettle();

    expect(tester.takeException(), isNull);
  });
}
