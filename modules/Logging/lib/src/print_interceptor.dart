import 'package:cuid2/cuid2.dart';
import 'package:flutter/foundation.dart' show debugPrint;

import 'log_bus.dart';
import 'log_entry.dart';

/// `debugPrintRebuildDirtyWidgets` prints exactly `'Building $this'` or
/// `'Rebuilding $this'` per dirty element (see `Element.rebuild()` in
/// `framework.dart`), so lines starting with either word are routed to the
/// widget-rebuild store instead of the normal log store.
bool isWidgetRebuildLine(String message) {
  final trimmed = message.trimLeft();
  return trimmed.startsWith('Building ') || trimmed.startsWith('Rebuilding ');
}

final RegExp _rebuiltWidgetNamePattern = RegExp(
  r'^(?:Building|Rebuilding) (\w+)',
);

/// `BuildTracker` (see `lib/main.dart`, wrapping the whole routed app for
/// `flutter_build_tracker`'s own stats) rebuilds itself once per rendered
/// frame by design, via its inner `Builder`, entirely independent of the
/// app's actual rebuild frequency — so its own `Building`/`Rebuilding`
/// lines are pure debug-tooling noise, never useful debugging signal, and
/// are dropped instead of being routed to the widget-rebuild log.
bool _isBuildTrackerNoise(String widgetRebuildLine) {
  final name = _rebuiltWidgetNamePattern.firstMatch(widgetRebuildLine)?.group(1);
  return name == 'BuildTracker' || name == 'Builder';
}

/// Replaces the framework's global `debugPrint` so every line printed
/// through it — whether from `debugPrintRebuildDirtyWidgets`, `debugPrint`
/// call sites elsewhere in the app, or third-party packages — is
/// classified and routed to [LogBus] instead of only reaching the console.
void installDebugPrintInterceptor() {
  final previous = debugPrint;
  debugPrint = (String? message, {int? wrapWidth}) {
    if (message == null) return;
    final timestamp = DateTime.now();
    if (isWidgetRebuildLine(message)) {
      if (_isBuildTrackerNoise(message.trimLeft())) return;
      LogBus.instance.addWidgetRebuild(
        LogEntry.widgetRebuild(
          id: cuid(),
          timestamp: timestamp,
          level: LogLevel.debug,
          source: WidgetRebuildLogSource.debugPrintRebuildDirtyWidgets,
          description: message,
        ),
      );
      return;
    }
    LogBus.instance.addNormal(
      LogEntry.message(
        id: cuid(),
        timestamp: timestamp,
        level: LogLevel.debug,
        message: message,
      ),
    );
    previous(message, wrapWidth: wrapWidth);
  };
}
