import 'package:flutter/material.dart';

import 'package:app_logging/app_logging.dart';
import 'package:denpamemo_widgets/denpamemo_widgets.dart'
    hide BuildContextTranslationsExtension, Translations;

import '../../i18n/gen/strings.g.dart';
import 'debug_log_menu.dart';
import 'log_category_tab_view.dart';

/// Debug-only screen (pushed from the settings list's developer section)
/// showing the three log stores from `package:app_logging`: normal
/// messages, widget-rebuild activity, and network requests. Owns only the
/// tab selection; entry display lives in [LogCategoryTabView] and the
/// overflow-menu actions in [DebugLogMenu].
class DebugLogPage extends StatefulWidget {
  const DebugLogPage({super.key});

  @override
  State<DebugLogPage> createState() => _DebugLogPageState();
}

class _DebugLogPageState extends State<DebugLogPage>
    with SingleTickerProviderStateMixin {
  late final TabController _tabController = TabController(
    length: LogCategory.values.length,
    vsync: this,
  )..addListener(_onTabChanged);

  LogCategory _selectedCategory = LogCategory.values.first;

  void _onTabChanged() {
    final category = LogCategory.values[_tabController.index];
    if (category != _selectedCategory) {
      setState(() => _selectedCategory = category);
    }
  }

  @override
  void dispose() {
    _tabController
      ..removeListener(_onTabChanged)
      ..dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final t = context.t;
    return AppScaffold(
      title: OutlinedTitleText(text: t.debugLog.title),
      belowHeader: TabBar(
        controller: _tabController,
        tabs: [
          Tab(text: t.debugLog.tabNormal),
          Tab(text: t.debugLog.tabWidgetRebuild),
          Tab(text: t.debugLog.tabNetwork),
        ],
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
