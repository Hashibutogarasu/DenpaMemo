import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../i18n/gen/strings.g.dart';
import '../../routing/app_router.dart';

/// Standard [NavigationBar] with the app's four top-level destinations,
/// mounted in [AppScaffold] so it appears on every page. The selected tab
/// is derived from the current route's path rather than tracked in state,
/// so it stays correct across restarts and deep links.
class AppBottomNavigationBar extends StatelessWidget {
  const AppBottomNavigationBar({super.key});

  static int _indexForPath(String path) {
    if (path.startsWith('/search')) return 1;
    if (path.startsWith('/analysis')) return 2;
    if (path.startsWith('/settings')) return 3;
    return 0;
  }

  @override
  Widget build(BuildContext context) {
    final t = context.t;
    final path = GoRouterState.of(context).uri.path;

    return NavigationBar(
      selectedIndex: _indexForPath(path),
      onDestinationSelected: (index) {
        switch (index) {
          case 0:
            const HomeRoute().go(context);
          case 1:
            const SearchRoute().go(context);
          case 2:
            const AnalysisRoute().go(context);
          case 3:
            const SettingsRoute().go(context);
        }
      },
      destinations: [
        NavigationDestination(
          icon: const Icon(Icons.home_outlined),
          selectedIcon: const Icon(Icons.home),
          label: t.page.home,
        ),
        NavigationDestination(
          icon: const Icon(Icons.search_outlined),
          selectedIcon: const Icon(Icons.search),
          label: t.page.search,
        ),
        NavigationDestination(
          icon: const Icon(Icons.analytics_outlined),
          selectedIcon: const Icon(Icons.analytics),
          label: t.page.analysis,
        ),
        NavigationDestination(
          icon: const Icon(Icons.settings_outlined),
          selectedIcon: const Icon(Icons.settings),
          label: t.page.settings,
        ),
      ],
    );
  }
}
