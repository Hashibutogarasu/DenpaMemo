import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../pages/denpa_men_editor.dart';
import '../pages/home.dart';
import '../pages/settings.dart';

part 'app_router.g.dart';

final GoRouter appRouter = GoRouter(routes: $appRoutes);

@TypedGoRoute<HomeRoute>(path: '/')
class HomeRoute extends GoRouteData with $HomeRoute {
  const HomeRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) => const Home();
}

@TypedGoRoute<SettingsRoute>(path: '/settings')
class SettingsRoute extends GoRouteData with $SettingsRoute {
  const SettingsRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) => const Settings();
}

/// Pushed (never `go`-navigated to) so it lands on top of the page stack,
/// which is what makes [AppScaffold]'s `context.canPop()` check show a back
/// button here. [$extra] carries the [MasterData] / [DenpaMenRecord] this
/// needs, since neither can round-trip through a URL.
@TypedGoRoute<AddDenpaMenRoute>(path: '/add')
class AddDenpaMenRoute extends GoRouteData with $AddDenpaMenRoute {
  const AddDenpaMenRoute({this.$extra});

  final DenpaMenEditorArgs? $extra;

  @override
  Widget build(BuildContext context, GoRouterState state) => DenpaMenEditor(
    masterData: $extra!.masterData,
    initial: $extra!.initial,
  );
}
