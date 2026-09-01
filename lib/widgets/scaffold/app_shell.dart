import 'package:flutter/material.dart';

import '../navigation/app_bottom_navigation_bar.dart';
import 'app_shell_progress_bar.dart';

/// Root-tab shell: wraps the router's [ShellRoute] navigator for the four
/// top-level destinations (home, search, analysis, settings) with the
/// persistent [AppBottomNavigationBar]. Pushed pages, such as
/// `SearchResults`, live outside this shell and therefore never show the
/// bottom navigation bar.
class AppShell extends StatelessWidget {
  const AppShell({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: child,
      bottomNavigationBar: const Column(
        mainAxisSize: MainAxisSize.min,
        children: [AppShellProgressBar(), AppBottomNavigationBar()],
      ),
    );
  }
}
