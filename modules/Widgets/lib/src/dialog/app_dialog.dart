import 'package:flutter/material.dart';

import '../theme/dialog_transition_theme.dart';

/// Drop-in replacement for [showDialog]: same defaults and result, but the
/// open/close transition (a slide combined with a fade, sliding up to open
/// and down to close) is driven by [DialogTransitionThemeData] instead of
/// [DialogRoute]'s fixed fade-only transition.
abstract final class AppDialog {
  static Future<T?> show<T>({
    required BuildContext context,
    required WidgetBuilder builder,
    bool barrierDismissible = true,
    Color? barrierColor,
    bool useSafeArea = true,
    bool useRootNavigator = true,
    RouteSettings? routeSettings,
  }) {
    final navigator = Navigator.of(context, rootNavigator: useRootNavigator);
    final themes = InheritedTheme.capture(from: context, to: navigator.context);
    final transitionTheme = Theme.of(
      context,
    ).extension<DialogTransitionThemeData>()!;
    final resolvedBarrierColor =
        barrierColor ??
        Theme.of(context).dialogTheme.barrierColor ??
        Colors.black54;
    final barrierLabel = MaterialLocalizations.of(
      context,
    ).modalBarrierDismissLabel;

    return navigator.push<T>(
      RawDialogRoute<T>(
        pageBuilder: (context, animation, secondaryAnimation) {
          final dialog = themes.wrap(Builder(builder: builder));
          return useSafeArea ? SafeArea(child: dialog) : dialog;
        },
        barrierDismissible: barrierDismissible,
        barrierLabel: barrierLabel,
        barrierColor: resolvedBarrierColor,
        transitionDuration: transitionTheme.duration,
        transitionBuilder: (context, animation, secondaryAnimation, child) {
          final curved = CurvedAnimation(
            parent: animation,
            curve: transitionTheme.curve,
            reverseCurve: transitionTheme.reverseCurve,
          );
          return FadeTransition(
            opacity: curved,
            child: SlideTransition(
              position: Tween<Offset>(
                begin: transitionTheme.beginOffset,
                end: Offset.zero,
              ).animate(curved),
              child: child,
            ),
          );
        },
        settings: routeSettings,
      ),
    );
  }
}
