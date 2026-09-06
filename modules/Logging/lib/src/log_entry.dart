import 'package:freezed_annotation/freezed_annotation.dart';

part 'log_entry.freezed.dart';

/// Severity of a [LogEntry.message] entry, mirroring the levels the
/// `logger` package prints with.
enum LogLevel { trace, debug, info, warning, error, fatal }

/// Which mechanism produced a [LogEntry.widgetRebuild] entry.
enum WidgetRebuildLogSource { debugPrintRebuildDirtyWidgets, buildTracker }

/// Which transport a [LogEntry.network] entry was recorded for.
enum NetworkProtocol { rest, graphql }

/// Single entry recorded into one of the debug log screen's three stores
/// (normal, widget-rebuild, network). Every variant shares [id] and
/// [timestamp]; the remaining fields are specific to what produced it.
@freezed
sealed class LogEntry with _$LogEntry {
  const factory LogEntry.message({
    required String id,
    required DateTime timestamp,
    required LogLevel level,
    required String message,
  }) = MessageLogEntry;

  const factory LogEntry.widgetRebuild({
    required String id,
    required DateTime timestamp,
    required LogLevel level,
    required WidgetRebuildLogSource source,
    required String description,
  }) = WidgetRebuildLogEntry;

  const factory LogEntry.network({
    required String id,
    required DateTime timestamp,
    required LogLevel level,
    required NetworkProtocol protocol,
    String? operation,
    String? requestBody,
    String? responseBody,
    int? statusCode,
    String? errorMessage,
    Duration? duration,
  }) = NetworkLogEntry;
}
