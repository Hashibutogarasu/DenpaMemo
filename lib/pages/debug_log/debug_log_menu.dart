import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart' show debugPaintSizeEnabled;
import 'package:flutter/services.dart' show Clipboard, ClipboardData;

import 'package:app_logging/app_logging.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:toaster/toaster.dart';

import '../../i18n/gen/strings.g.dart';
import '../../providers/app_settings_providers.dart';
import 'debug_log_view_model.dart';

/// The Switch item toggling `debugPaintSizeEnabled`, isolated in its own
/// widget so it can rebuild itself (via [StatefulBuilder]) without the
/// enclosing popup-menu route needing to know about it.
class DebugPaintToggleMenuItem extends ConsumerWidget {
  const DebugPaintToggleMenuItem({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final t = context.t;
    final viewModel = ref.read(debugLogViewModelProvider);
    return StatefulBuilder(
      builder: (context, setMenuItemState) => Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(t.debugLog.debugPaintSize),
          Switch(
            value: debugPaintSizeEnabled,
            onChanged: (_) =>
                setMenuItemState(viewModel.toggleDebugPaintSizeEnabled),
          ),
        ],
      ),
    );
  }
}

/// The Switch item toggling `AppSettings.buildTrackerEnabled` (`BuildTracker`
/// and `debugPrintRebuildDirtyWidgets`), backed by [appSettingsProvider] so
/// it redraws on its own once [DebugLogViewModel.toggleWidgetRebuildTrackingEnabled]
/// saves the new value.
class WidgetRebuildTrackingToggleMenuItem extends ConsumerWidget {
  const WidgetRebuildTrackingToggleMenuItem({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final t = context.t;
    final enabled = ref.watch(appSettingsProvider).buildTrackerEnabled;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(t.debugLog.widgetRebuildTracking),
        Switch(
          value: enabled,
          onChanged: (_) => ref
              .read(debugLogViewModelProvider)
              .toggleWidgetRebuildTrackingEnabled(),
        ),
      ],
    );
  }
}

/// The debug log screen's AppBar overflow menu: copy the current tab's
/// entries or log file path, clear the current tab, and toggle debug
/// paint. All data operations delegate to [DebugLogViewModel].
class DebugLogMenu extends ConsumerWidget {
  const DebugLogMenu({super.key, required this.category});

  final LogCategory category;

  Future<void> _copyEntries(BuildContext context, WidgetRef ref) async {
    final t = context.t;
    final text = ref.read(debugLogViewModelProvider).formattedTextFor(category);
    await Clipboard.setData(ClipboardData(text: text));
    if (!context.mounted) return;
    await Toaster.show(context, t.settings.copiedToast(label: t.debugLog.copy));
  }

  Future<void> _copyLogFilePath(BuildContext context, WidgetRef ref) async {
    final path = ref.read(debugLogViewModelProvider).logFilePathFor(category);
    if (path == null) return;
    final t = context.t;
    await Clipboard.setData(ClipboardData(text: path));
    if (!context.mounted) return;
    await Toaster.show(
      context,
      t.settings.copiedToast(label: t.debugLog.copyLogFilePath),
    );
  }

  void _clear(WidgetRef ref) =>
      ref.read(debugLogViewModelProvider).clear(category);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final t = context.t;
    return PopupMenuButton<VoidCallback>(
      onSelected: (action) => action(),
      itemBuilder: (context) => [
        PopupMenuItem(
          value: () => _copyEntries(context, ref),
          child: Text(t.debugLog.copy),
        ),
        PopupMenuItem(
          value: () => _copyLogFilePath(context, ref),
          child: Text(t.debugLog.copyLogFilePath),
        ),
        PopupMenuItem(value: () => _clear(ref), child: Text(t.debugLog.clear)),
        PopupMenuItem(value: () {}, child: const DebugPaintToggleMenuItem()),
        PopupMenuItem(
          value: () {},
          child: const WidgetRebuildTrackingToggleMenuItem(),
        ),
      ],
    );
  }
}
