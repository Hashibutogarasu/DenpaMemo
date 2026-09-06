import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'log_bus.dart';
import 'log_entry.dart';

/// Entries older than the newest [maxEntries] are dropped so a long-lived
/// debug session never grows [LogEntry] storage without bound.
const int maxEntries = 500;

/// How often buffered entries are flushed into Riverpod state. A burst of
/// log lines (e.g. `debugPrintRebuildDirtyWidgets` spam during a heavy
/// rebuild) is coalesced into at most one state update per interval,
/// instead of one widget rebuild per line, which otherwise tanks the
/// frame rate while the debug log screen is open.
const Duration flushInterval = Duration(milliseconds: 200);

/// Base for the three debug log screen stores: each subscribes to one
/// [LogBus] stream via [logBusStream], buffers incoming entries, and
/// flushes them into state at most once per [flushInterval], keeping the
/// newest [maxEntries] entries newest first.
///
/// [pauseLiveUpdates] lets a screen that is *itself* watching this state
/// (and would therefore rebuild in response to its own new entries) stop
/// new entries from reaching [state] while it's the one on screen —
/// see [WidgetRebuildLogNotifier], where displaying a rebuild also
/// produces a rebuild, which would otherwise feed right back into the
/// same stream forever. Entries keep accumulating in [_pending] while
/// paused (capped at [maxEntries] so a long pause can't grow it without
/// bound) and are flushed once resumed.
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
  /// that arrive afterward — for a screen that wants to catch up exactly
  /// once as it becomes visible (e.g. a tab being selected) and then go
  /// back to not live-updating.
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

/// Backs the network-log tab: REST ([LoggingHttpClient]) and GraphQL
/// ([LoggingGraphQLLink]) requests.
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
