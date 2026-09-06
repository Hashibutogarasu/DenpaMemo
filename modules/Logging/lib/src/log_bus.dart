import 'dart:async';

import 'log_entry.dart';

/// Process-wide sink for [LogEntry]s, independent of any provider
/// container's lifecycle. Interceptors and network wrappers run before the
/// widget tree (and its `ProviderScope`) exists, so they publish here
/// instead of reading a provider directly; the log store notifiers in
/// `log_store.dart` subscribe to the matching stream to mirror entries
/// into Riverpod state for the debug log screen.
class LogBus {
  LogBus._();

  static final LogBus instance = LogBus._();

  final StreamController<LogEntry> _normal = StreamController.broadcast();
  final StreamController<LogEntry> _widgetRebuild =
      StreamController.broadcast();
  final StreamController<LogEntry> _network = StreamController.broadcast();

  Stream<LogEntry> get normal => _normal.stream;

  Stream<LogEntry> get widgetRebuild => _widgetRebuild.stream;

  Stream<LogEntry> get network => _network.stream;

  void addNormal(LogEntry entry) => _normal.add(entry);

  void addWidgetRebuild(LogEntry entry) => _widgetRebuild.add(entry);

  void addNetwork(LogEntry entry) => _network.add(entry);
}
