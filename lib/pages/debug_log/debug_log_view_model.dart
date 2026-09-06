import 'package:flutter/rendering.dart' show debugPaintSizeEnabled;
import 'package:flutter/widgets.dart';

import 'package:app_logging/app_logging.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../logging/log_file_bridge.dart';

/// Data operations for the debug log screen (reading/clearing a
/// category's entries, resolving its log file path, toggling debug
/// paint), kept out of the widget tree so the views stay presentation-only.
class DebugLogViewModel {
  DebugLogViewModel(this._ref);

  final Ref _ref;

  List<LogEntry> entriesFor(LogCategory category) => switch (category) {
    LogCategory.normal => _ref.read(normalLogProvider),
    LogCategory.widgetRebuild => _ref.read(widgetRebuildLogProvider),
    LogCategory.network => _ref.read(networkLogProvider),
  };

  String formattedTextFor(LogCategory category) =>
      entriesFor(category).map(formatLogEntry).join('\n');

  String? logFilePathFor(LogCategory category) =>
      logFileWriter?.pathFor(category);

  void clear(LogCategory category) {
    switch (category) {
      case LogCategory.normal:
        _ref.read(normalLogProvider.notifier).clear();
      case LogCategory.widgetRebuild:
        _ref.read(widgetRebuildLogProvider.notifier).clear();
      case LogCategory.network:
        _ref.read(networkLogProvider.notifier).clear();
    }
  }

  /// Toggles `debugPaintSizeEnabled` and forces a full repaint so the
  /// change is visible immediately, mirroring how Flutter's own "debug
  /// paint" DevTools toggle applies the flag via `BuildOwner.reassemble`.
  void toggleDebugPaintSizeEnabled() {
    debugPaintSizeEnabled = !debugPaintSizeEnabled;
    final rootElement = WidgetsBinding.instance.rootElement;
    if (rootElement != null) {
      WidgetsBinding.instance.buildOwner!.reassemble(rootElement);
    }
  }
}

final debugLogViewModelProvider = Provider(DebugLogViewModel.new);
