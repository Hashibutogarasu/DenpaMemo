import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';

/// Wraps [router] as the nearest [Router] ancestor, for widgets that read
/// `GoRouterState.of(context)` or call `.go(context)`. [router] must be a
/// module-level singleton built once, never constructed inline inside a
/// use case function — a brand new [GoRouter] built on every rebuild
/// makes [Router] tear down and reinitialize each time, which can itself
/// schedule another frame: an infinite rebuild loop with no thrown
/// exception, just a frozen app.
Widget routerPreview(GoRouter router) {
  return Router.withConfig(config: router);
}
