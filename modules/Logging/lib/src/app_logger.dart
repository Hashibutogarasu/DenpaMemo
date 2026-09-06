import 'package:cuid2/cuid2.dart';
import 'package:logger/logger.dart';

import 'log_bus.dart';
import 'log_entry.dart';

LogLevel _mapLevel(Level level) => switch (level) {
  Level.trace => LogLevel.trace,
  Level.debug => LogLevel.debug,
  Level.warning => LogLevel.warning,
  Level.error => LogLevel.error,
  Level.fatal => LogLevel.fatal,
  _ => LogLevel.info,
};

/// Forwards every `logger` package output line to [LogBus.addNormal] as a
/// [LogEntry.message], instead of (or in addition to) printing to the
/// console.
class LogBusOutput extends LogOutput {
  @override
  void output(OutputEvent event) {
    LogBus.instance.addNormal(
      LogEntry.message(
        id: cuid(),
        timestamp: DateTime.now(),
        level: _mapLevel(event.level),
        message: event.lines.join('\n'),
      ),
    );
  }
}

/// App-wide wrapper around a single `logger` package [Logger] instance,
/// routing every call into `normalLogProvider` via [LogBus].
class AppLogger {
  AppLogger()
    : _logger = Logger(
        printer: SimplePrinter(colors: false),
        output: LogBusOutput(),
      );

  final Logger _logger;

  void trace(String message) => _logger.t(message);

  void debug(String message) => _logger.d(message);

  void info(String message) => _logger.i(message);

  void warning(String message) => _logger.w(message);

  void error(String message, [Object? error, StackTrace? stackTrace]) =>
      _logger.e(message, error: error, stackTrace: stackTrace);
}

/// App-wide [AppLogger] instance, so any part of the app can log without
/// needing one injected through Riverpod.
final AppLogger appLogger = AppLogger();
