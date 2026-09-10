import 'dart:async';

import 'log_entry.dart';

/// Entries older than the newest [maxEntries] are dropped from both
/// [LogBus]'s own replay history and the debug log stores in
/// `log_store.dart`, so a long-lived debug session never grows [LogEntry]
/// storage without bound.
const int maxEntries = 500;

/// One [LogBus] stream's broadcast controller plus a bounded replay
/// history, so a listener that subscribes after entries were already
/// published (e.g. the debug log screen, opened well after app-startup
/// network traffic already happened) still sees them.
class _ReplayChannel {
  final List<LogEntry> _history = [];
  final _controller = StreamController<LogEntry>.broadcast();

  Stream<LogEntry> get stream async* {
    yield* Stream.fromIterable(List.of(_history));
    yield* _controller.stream;
  }

  void add(LogEntry entry) {
    _history.add(entry);
    if (_history.length > maxEntries) {
      _history.removeRange(0, _history.length - maxEntries);
    }
    _controller.add(entry);
  }
}

/// Process-wide sink for [LogEntry]s, independent of any provider
/// container's lifecycle. Interceptors publish here directly (they run
/// before the widget tree exists); `log_store.dart`'s notifiers subscribe
/// to mirror entries into Riverpod state for the debug log screen.
class LogBus {
  LogBus._();

  static final LogBus instance = LogBus._();

  final _normal = _ReplayChannel();
  final _widgetRebuild = _ReplayChannel();
  final _network = _ReplayChannel();

  Stream<LogEntry> get normal => _normal.stream;

  Stream<LogEntry> get widgetRebuild => _widgetRebuild.stream;

  Stream<LogEntry> get network => _network.stream;

  void addNormal(LogEntry entry) => _normal.add(entry);

  void addWidgetRebuild(LogEntry entry) => _widgetRebuild.add(entry);

  void addNetwork(LogEntry entry) => _network.add(entry);
}
