import 'package:flutter/material.dart';

import 'package:app_logging/app_logging.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:denpa_memo/widgets.dart' hide Translations;
import '../../i18n/gen/strings.g.dart';
import 'debug_log_menu.dart';
import 'log_category_tab_view.dart';

/// Debug-only screen (pushed from the settings list's developer section)
/// showing the three log stores from `package:app_logging`: normal
/// messages, widget-rebuild activity, and network requests. Owns only the
/// tab selection; entry display lives in [LogCategoryTabView] and the
/// overflow-menu actions in [DebugLogMenu].
class DebugLogPage extends ConsumerStatefulWidget {
  const DebugLogPage({super.key});

  @override
  ConsumerState<DebugLogPage> createState() => _DebugLogPageState();
}

class _DebugLogPageState extends ConsumerState<DebugLogPage>
    with SingleTickerProviderStateMixin {
  late final TabController _tabController = TabController(
    length: LogCategory.values.length,
    vsync: this,
  )..addListener(_onTabChanged);

  LogCategory _selectedCategory = LogCategory.values.first;

  @override
  void initState() {
    super.initState();
    // Displaying the widget-rebuild tab's own entries produces more
    // rebuilds, which would otherwise feed right back into the same log
    // forever (see WidgetRebuildLogNotifier.pauseLiveUpdates) — so it
    // never live-updates on its own while this page is open, however many
    // of its tabs `TabBarView` happens to keep mounted at once. It only
    // gets a fresh snapshot at the moment it becomes the selected tab
    // (see _onTabChanged), then goes back to not live-updating.
    ref.read(widgetRebuildLogProvider.notifier).pauseLiveUpdates(true);
  }

  void _onTabChanged() {
    final category = LogCategory.values[_tabController.index];
    if (category != _selectedCategory) {
      setState(() => _selectedCategory = category);
    }
    if (category == LogCategory.widgetRebuild) {
      ref.read(widgetRebuildLogProvider.notifier).flushPendingOnce();
    }
  }

  @override
  void dispose() {
    _tabController
      ..removeListener(_onTabChanged)
      ..dispose();
    ref.read(widgetRebuildLogProvider.notifier).pauseLiveUpdates(false);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final t = context.t;
    return AppScaffold(
      title: OutlinedTitleText(text: t.debugLog.title),
      belowHeader: ColoredBox(
        color: Theme.of(context).colorScheme.surface,
        child: TabBar(
          controller: _tabController,
          tabs: [
            Tab(text: t.debugLog.tabNormal),
            Tab(text: t.debugLog.tabWidgetRebuild),
            Tab(text: t.debugLog.tabNetwork),
          ],
        ),
      ),
      actions: [DebugLogMenu(category: _selectedCategory)],
      body: TabBarView(
        controller: _tabController,
        children: [
          for (final category in LogCategory.values)
            LogCategoryTabView(
              category: category,
              emptyLabel: t.debugLog.empty,
            ),
        ],
      ),
    );
  }
}
