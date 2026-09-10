import 'dart:async';

import 'package:cuid2/cuid2.dart';

import 'log_bus.dart';
import 'log_entry.dart';

/// Runs [body] inside a [Zone] that routes `print` lines and otherwise
/// uncaught async errors into [LogBus.addNormal] as well as the console,
/// so async errors are handled here instead of reaching the root zone,
/// which would otherwise trip an attached debugger's exception breakpoint.
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
      handleUncaughtError: (self, parent, zone, error, stackTrace) {
        LogBus.instance.addNormal(
          LogEntry.message(
            id: cuid(),
            timestamp: DateTime.now(),
            level: LogLevel.error,
            message: '$error\n$stackTrace',
          ),
        );
        parent.print(zone, '$error\n$stackTrace');
      },
    ),
  );
}
