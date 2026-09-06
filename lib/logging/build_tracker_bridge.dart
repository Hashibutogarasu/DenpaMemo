import 'package:app_logging/app_logging.dart';
import 'package:cuid2/cuid2.dart';
import 'package:flutter_build_tracker/flutter_build_tracker.dart';

/// Shared [BuildTrackerController] passed to every [BuildTracker] in the
/// app, so [installBuildTrackerBridge] can observe every tracked widget's
/// stats from one place.
final BuildTrackerController buildTrackerController = BuildTrackerController();

final Map<String, int> _lastBuildCounts = {};

/// Mirrors [buildTrackerController] updates into [LogBus] as
/// [LogEntry.widgetRebuild] entries, one per widget whose `buildCount`
/// actually changed since the last notification (the controller notifies
/// on every tracked widget's rebuild, not just the one that changed).
void installBuildTrackerBridge() {
  buildTrackerController.addListener(() {
    for (final entry in buildTrackerController.allStats.entries) {
      final stats = entry.value;
      if (_lastBuildCounts[entry.key] == stats.buildCount) continue;
      _lastBuildCounts[entry.key] = stats.buildCount;
      LogBus.instance.addWidgetRebuild(
        LogEntry.widgetRebuild(
          id: cuid(),
          timestamp: DateTime.now(),
          level: LogLevel.debug,
          source: WidgetRebuildLogSource.buildTracker,
          description: stats.toString(),
        ),
      );
    }
  });
}
