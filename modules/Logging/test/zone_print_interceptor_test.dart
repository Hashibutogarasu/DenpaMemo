import 'dart:async';

import 'package:app_logging/app_logging.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('an async error escaping body as a genuinely uncaught zone error is '
      'routed to LogBus instead of reaching the root zone unhandled', () async {
    final logged = LogBus.instance.normal.firstWhere(
      (entry) => entry is MessageLogEntry && entry.level == LogLevel.error,
    );

    runZonedWithPrintInterceptor(() {
      scheduleMicrotask(() => throw StateError('boom'));
    });

    final entry = await logged.timeout(const Duration(seconds: 2));
    expect((entry as MessageLogEntry).message, contains('boom'));
  });
}
