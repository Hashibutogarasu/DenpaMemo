import 'dart:isolate';

import 'log_entry.dart';

String _twoDigits(int value) => value.toString().padLeft(2, '0');

String _threeDigits(int value) => value.toString().padLeft(3, '0');

String formatLogTimestamp(DateTime timestamp) =>
    '${_twoDigits(timestamp.hour)}:'
    '${_twoDigits(timestamp.minute)}:'
    '${_twoDigits(timestamp.second)}.'
    '${_threeDigits(timestamp.millisecond)}';

String _formatDateTime(DateTime timestamp) =>
    '${timestamp.year}-${_twoDigits(timestamp.month)}-${_twoDigits(timestamp.day)} '
    '${formatLogTimestamp(timestamp)}';

String get _currentThreadName => Isolate.current.debugName ?? 'main';

String _text(LogEntry entry) => switch (entry) {
  MessageLogEntry() => entry.message,
  WidgetRebuildLogEntry() => entry.description,
  NetworkLogEntry() => [
    entry.operation,
    entry.statusCode?.toString(),
    entry.errorMessage,
  ].whereType<String>().join(' '),
};

/// Renders one [LogEntry] as a single `[datetime][thread][level] text`
/// line, shared by the debug log screen (for display and clipboard copy)
/// and [LogFileWriter] (for the on-disk log files), so both stay in sync.
/// [LogEntry.level] is set by whichever producer created the entry (the
/// `logger` package call site, the network client, ...), never guessed
/// here.
String formatLogEntry(LogEntry entry) =>
    '[${_formatDateTime(entry.timestamp)}]'
    '[$_currentThreadName]'
    '[${entry.level.name.toUpperCase()}] ${_text(entry)}';
