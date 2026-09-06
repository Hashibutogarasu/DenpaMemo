import 'dart:async';
import 'dart:io';

import 'package:path/path.dart' as p;

import 'log_bus.dart';
import 'log_category.dart';
import 'log_entry.dart';
import 'log_formatter.dart';

/// How often buffered lines are flushed to disk. Matches
/// [LogStoreNotifier]'s flush cadence, so a burst of log lines results in
/// one batched file write rather than one write per line.
const Duration logFileFlushInterval = Duration(milliseconds: 500);

String _twoDigits(int value) => value.toString().padLeft(2, '0');

String _sessionTimestamp(DateTime timestamp) =>
    '${timestamp.year}${_twoDigits(timestamp.month)}${_twoDigits(timestamp.day)}'
    '_${_twoDigits(timestamp.hour)}${_twoDigits(timestamp.minute)}${_twoDigits(timestamp.second)}';

/// Writes every [LogEntry] published on [LogBus] to one `.log` file per
/// [LogCategory], under `<logsDirectory>/<epoch day>/`. The epoch-day
/// subfolder groups files by calendar day; the session timestamp in each
/// file name keeps multiple app runs on the same day from colliding.
class LogFileWriter {
  LogFileWriter({required this.logsDirectory});

  final Directory logsDirectory;

  final Map<LogCategory, IOSink> _sinks = {};
  final Map<LogCategory, List<String>> _pendingLines = {
    for (final category in LogCategory.values) category: [],
  };
  final Map<LogCategory, String> _filePaths = {};
  final List<StreamSubscription<LogEntry>> _subscriptions = [];
  Timer? _flushTimer;

  String? pathFor(LogCategory category) => _filePaths[category];

  Future<void> start() async {
    final now = DateTime.now();
    final epochDay = now.millisecondsSinceEpoch ~/ Duration.millisecondsPerDay;
    final dayDirectory = Directory(p.join(logsDirectory.path, '$epochDay'));
    await dayDirectory.create(recursive: true);
    final sessionTimestamp = _sessionTimestamp(now);

    for (final category in LogCategory.values) {
      final filePath = p.join(
        dayDirectory.path,
        '$sessionTimestamp-${category.fileNameSegment}.log',
      );
      _filePaths[category] = filePath;
      _sinks[category] = File(filePath).openWrite(mode: FileMode.append);
    }

    _subscriptions.addAll([
      LogBus.instance.normal.listen(
        (entry) =>
            _pendingLines[LogCategory.normal]!.add(formatLogEntry(entry)),
      ),
      LogBus.instance.widgetRebuild.listen(
        (entry) => _pendingLines[LogCategory.widgetRebuild]!.add(
          formatLogEntry(entry),
        ),
      ),
      LogBus.instance.network.listen(
        (entry) =>
            _pendingLines[LogCategory.network]!.add(formatLogEntry(entry)),
      ),
    ]);

    _flushTimer = Timer.periodic(logFileFlushInterval, (_) => _flush());
  }

  void _flush() {
    for (final category in LogCategory.values) {
      final lines = _pendingLines[category]!;
      if (lines.isEmpty) continue;
      final sink = _sinks[category]!;
      for (final line in lines) {
        sink.writeln(line);
      }
      lines.clear();
    }
  }

  Future<void> dispose() async {
    _flushTimer?.cancel();
    for (final subscription in _subscriptions) {
      await subscription.cancel();
    }
    _flush();
    for (final sink in _sinks.values) {
      await sink.flush();
      await sink.close();
    }
  }
}
