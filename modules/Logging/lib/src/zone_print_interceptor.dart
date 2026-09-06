import 'dart:async';

import 'package:cuid2/cuid2.dart';

import 'log_bus.dart';
import 'log_entry.dart';

/// Runs [body] inside a [Zone] whose `print` is overridden to also route
/// every line to [LogBus.addNormal] as a [LogEntry.message], on top of
/// printing to the console as usual. Use this to wrap the app's `runApp`
/// call so bare `print()` statements reach the normal-log tab.
R runZonedWithPrintInterceptor<R>(R Function() body) {
  return runZoned(
    body,
    zoneSpecification: ZoneSpecification(
      print: (self, parent, zone, line) {
        LogBus.instance.addNormal(
          LogEntry.message(
            id: cuid(),
            timestamp: DateTime.now(),
            level: LogLevel.debug,
            message: line,
          ),
        );
        parent.print(zone, line);
      },
    ),
  );
}
