import 'package:flutter/widgets.dart';

import 'responsive.dart';

/// Single source of truth for whether the app should use its mobile
/// layout. Wraps the whole app once (see the root `MaterialApp.builder`)
/// and computes [isMobileWidth] itself, so every descendant reads the
/// same value via [isMobileOf] instead of each independently recomputing
/// it from `MediaQuery` or duplicating it through separate app state.
class ResponsiveScope extends StatelessWidget {
  const ResponsiveScope({super.key, required this.child});

  final Widget child;

  /// Returns the nearest ancestor [ResponsiveScope]'s current value,
  /// and subscribes the calling context to rebuild when it changes. Falls
  /// back to computing [isMobileWidth] directly (still `MediaQuery`, just
  /// not shared/cached through a scope) when no ancestor [ResponsiveScope]
  /// exists, e.g. in a widget test that doesn't wrap its tree with one.
  static bool isMobileOf(BuildContext context) {
    final data = context
        .dependOnInheritedWidgetOfExactType<_ResponsiveScopeData>();
    return data?.isMobile ?? isMobileWidth(context);
  }

  @override
  Widget build(BuildContext context) {
    return _ResponsiveScopeData(isMobile: isMobileWidth(context), child: child);
  }
}

class _ResponsiveScopeData extends InheritedWidget {
  const _ResponsiveScopeData({required this.isMobile, required super.child});

  final bool isMobile;

  @override
  bool updateShouldNotify(_ResponsiveScopeData oldWidget) =>
      isMobile != oldWidget.isMobile;
}
