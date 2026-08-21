import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:denpa_memo/utils/responsive.dart';

void main() {
  Future<bool> pumpIsMobileWidth(WidgetTester tester, double width) async {
    late bool result;
    await tester.pumpWidget(
      MediaQuery(
        data: MediaQueryData(size: Size(width, 800)),
        child: Builder(
          builder: (context) {
            result = isMobileWidth(context);
            return const SizedBox.shrink();
          },
        ),
      ),
    );
    return result;
  }

  testWidgets('is true just below the breakpoint', (tester) async {
    expect(await pumpIsMobileWidth(tester, 599), isTrue);
  });

  testWidgets('is false exactly at the breakpoint', (tester) async {
    expect(await pumpIsMobileWidth(tester, 600), isFalse);
  });

  testWidgets('is false just above the breakpoint', (tester) async {
    expect(await pumpIsMobileWidth(tester, 601), isFalse);
  });
}
