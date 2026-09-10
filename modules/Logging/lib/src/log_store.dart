import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'log_bus.dart';
import 'log_entry.dart';

/// Entries older than the newest [maxEntries] are dropped so a long-lived
/// debug session never grows [LogEntry] storage without bound.
const int maxEntries = 500;

/// How often buffered entries are flushed into Riverpod state, coalescing
/// a burst of log lines into at most one state update per interval instead
/// of one widget rebuild per line.
const Duration flushInterval = Duration(milliseconds: 200);

/// Base for the three debug log screen stores: subscribes to one [LogBus]
/// stream via [logBusStream] and flushes buffered entries into state at
/// most once per [flushInterval]. [pauseLiveUpdates] stops a screen from
/// feeding its own new entries back into a rebuild loop while it's shown.
abstract class _LogBusNotifier extends Notifier<List<LogEntry>> {
  Stream<LogEntry> get logBusStream;

  final List<LogEntry> _pending = [];
  Timer? _flushTimer;
  bool _liveUpdatesPaused = false;

  @override
  List<LogEntry> build() {
    final subscription = logBusStream.listen(_addPending);
    _flushTimer = Timer.periodic(flushInterval, (_) => _flush());
    ref.onDispose(() {
      subscription.cancel();
      _flushTimer?.cancel();
    });
    return const [];
  }

  void _addPending(LogEntry entry) {
    _pending.add(entry);
    if (_pending.length > maxEntries) {
      _pending.removeRange(0, _pending.length - maxEntries);
    }
  }

  void pauseLiveUpdates(bool paused) {
    _liveUpdatesPaused = paused;
    if (!paused) {
      _flush();
    }
  }

  /// Applies whatever has accumulated in [_pending] right now as a one-off
  /// snapshot, even while paused, without lifting the pause for entries
  /// that arrive afterward — for a screen catching up once as it becomes
  /// visible, then going back to not live-updating.
  void flushPendingOnce() {
    final wasPaused = _liveUpdatesPaused;
    _liveUpdatesPaused = false;
    _flush();
    _liveUpdatesPaused = wasPaused;
  }

  void _flush() {
    if (_liveUpdatesPaused || _pending.isEmpty) return;
    state = [
      for (final entry in _pending.reversed) entry,
      ...state,
    ].take(maxEntries).toList(growable: false);
    _pending.clear();
  }

  void clear() {
    _pending.clear();
    state = const [];
  }
}

/// Backs the normal-log tab: `debugPrint`/`print` output, routed through
/// [AppLogger], excluding anything absorbed by [widgetRebuildLogProvider].
class NormalLogNotifier extends _LogBusNotifier {
  @override
  Stream<LogEntry> get logBusStream => LogBus.instance.normal;
}

/// Backs the widget-rebuild-log tab: `debugPrintRebuildDirtyWidgets`
/// output and `flutter_build_tracker` callbacks.
class WidgetRebuildLogNotifier extends _LogBusNotifier {
  @override
  Stream<LogEntry> get logBusStream => LogBus.instance.widgetRebuild;
}

/// Backs the network-log tab: both REST and GraphQL requests, captured by
/// the single [DioLoggingInterceptor] attached to the app's shared [Dio].
class NetworkLogNotifier extends _LogBusNotifier {
  @override
  Stream<LogEntry> get logBusStream => LogBus.instance.network;
}

final normalLogProvider = NotifierProvider<NormalLogNotifier, List<LogEntry>>(
  NormalLogNotifier.new,
);

final widgetRebuildLogProvider =
    NotifierProvider<WidgetRebuildLogNotifier, List<LogEntry>>(
      WidgetRebuildLogNotifier.new,
    );

final networkLogProvider = NotifierProvider<NetworkLogNotifier, List<LogEntry>>(
  NetworkLogNotifier.new,
);
