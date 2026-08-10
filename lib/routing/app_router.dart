import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../domain/master_data/master_data.dart';
import '../pages/birth_guide.dart';
import '../pages/denpa_men_editor.dart';
import '../pages/denpa_men_qr.dart';
import '../pages/home.dart';
import '../pages/qr_code_selection.dart';
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
/// needs, since neither can round-trip through a URL. The "complete" action
/// in a session (see [DenpaMenEditorArgs.sessionMode]) is the one exception
/// that navigates with `go` straight back to [HomeRoute], unwinding this
/// route and [DenpaMenQrRoute] together.
@TypedGoRoute<AddDenpaMenRoute>(path: '/add')
class AddDenpaMenRoute extends GoRouteData with $AddDenpaMenRoute {
  const AddDenpaMenRoute({this.$extra});

  final DenpaMenEditorArgs? $extra;

  @override
  Widget build(BuildContext context, GoRouterState state) => DenpaMenEditor(
    masterData: $extra!.masterData,
    initial: $extra!.initial,
    sessionMode: $extra!.sessionMode,
  );
}

/// Pushed before [AddDenpaMenRoute] when adding new individuals: shows the
/// session's QR code and, once "next" is pressed, hands off to
/// [DenpaMenEditor] in session mode. [$extra] carries the [MasterData]
/// needed to build a blank [DenpaMen].
@TypedGoRoute<DenpaMenQrRoute>(path: '/add/qr')
class DenpaMenQrRoute extends GoRouteData with $DenpaMenQrRoute {
  const DenpaMenQrRoute({this.$extra});

  final MasterData? $extra;

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      DenpaMenQrPage(masterData: $extra!);
}

/// Pushed before [AddDenpaMenRoute] when adding to an already-saved QR code:
/// lets the user pick which one, then hands off straight to [DenpaMenEditor]
/// in session mode (skipping [DenpaMenQrRoute], since an existing QR code's
/// raw value must not be regenerated). [$extra] carries the [MasterData]
/// needed to build a blank [DenpaMen].
@TypedGoRoute<QrCodeSelectionRoute>(path: '/add/qr-select')
class QrCodeSelectionRoute extends GoRouteData with $QrCodeSelectionRoute {
  const QrCodeSelectionRoute({this.$extra});

  final MasterData? $extra;

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      QrCodeSelectionPage(masterData: $extra!);
}

/// Pushed from the home list's per-individual menu when that individual has
/// parents: walks its ancestry backward, guiding the user through catching
/// and breeding the individuals needed to reach it again.
@TypedGoRoute<BirthGuideRoute>(path: '/birth-guide')
class BirthGuideRoute extends GoRouteData with $BirthGuideRoute {
  const BirthGuideRoute({this.$extra});

  final BirthGuideArgs? $extra;

  @override
  Widget build(BuildContext context, GoRouterState state) => BirthGuidePage(
    masterData: $extra!.masterData,
    target: $extra!.target,
  );
}
