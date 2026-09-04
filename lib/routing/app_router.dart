import 'package:data_pack/data_pack.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../data/server/physique_table_args.dart';
import '../pages/account_settings.dart';
import '../pages/analysis.dart';
import '../pages/birth_guide.dart';
import '../pages/cloud_backup.dart';
import '../pages/cloud_backup_history.dart';
import '../pages/clipping_settings.dart';
import '../pages/data_management.dart';
import '../pages/denpa_men_editor.dart';
import '../pages/denpa_men_qr.dart';
import '../pages/denpa_men_selection.dart';
import '../pages/denpa_men_selection_results.dart';
import '../pages/home.dart';
import '../pages/language_settings.dart';
import '../pages/monster_exp.dart';
import '../pages/monster_selection.dart';
import '../pages/open_source_licenses.dart';
import '../pages/physique_table_edit.dart';
import '../pages/physique_table_list.dart';
import '../pages/physique_table_view.dart';
import '../pages/qr_code_selection.dart';
import '../pages/search.dart';
import '../pages/search_results.dart';
import '../pages/settings.dart';
import '../pages/theme_settings.dart';
import '../widgets/scaffold/app_shell.dart';
import '../widgets/scaffold/cloud_backup_shell.dart';

part 'app_router.g.dart';

final GoRouter appRouter = GoRouter(routes: $appRoutes);

/// Wraps the four root-tab routes (home, search, analysis, settings) in
/// [AppShell], which owns the persistent bottom navigation bar. Routes
/// pushed on top — [SearchResultsRoute] and its siblings — are declared
/// outside this shell, so they never show that bar.
@TypedShellRoute<AppShellRouteData>(
  routes: [
    TypedGoRoute<HomeRoute>(path: '/'),
    TypedGoRoute<SettingsRoute>(path: '/settings'),
    TypedGoRoute<SearchRoute>(path: '/search'),
    TypedGoRoute<AnalysisRoute>(path: '/analysis'),
  ],
)
class AppShellRouteData extends ShellRouteData {
  const AppShellRouteData();

  @override
  Widget builder(BuildContext context, GoRouterState state, Widget navigator) =>
      AppShell(child: navigator);
}

class HomeRoute extends GoRouteData with $HomeRoute {
  const HomeRoute();

  @override
  Page<void> buildPage(BuildContext context, GoRouterState state) =>
      const NoTransitionPage(child: Home());
}

class SettingsRoute extends GoRouteData with $SettingsRoute {
  const SettingsRoute();

  @override
  Page<void> buildPage(BuildContext context, GoRouterState state) =>
      const NoTransitionPage(child: Settings());
}

class SearchRoute extends GoRouteData with $SearchRoute {
  const SearchRoute();

  @override
  Page<void> buildPage(BuildContext context, GoRouterState state) =>
      const NoTransitionPage(child: Search());
}

class AnalysisRoute extends GoRouteData with $AnalysisRoute {
  const AnalysisRoute();

  @override
  Page<void> buildPage(BuildContext context, GoRouterState state) =>
      const NoTransitionPage(child: Analysis());
}

/// Pushed (never `go`-navigated to) so the search page's back button
/// returns here, matching the [AddDenpaMenRoute] pattern. Declared outside
/// [AppShellRouteData] so it does not show the root bottom navigation bar.
@TypedGoRoute<SearchResultsRoute>(path: '/search/results')
class SearchResultsRoute extends GoRouteData with $SearchResultsRoute {
  const SearchResultsRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      const SearchResults();
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
/// needed to build a blank [DenpaMen], plus an optional raw value decoded
/// from an imported QR code image so the regenerated code matches it.
@TypedGoRoute<DenpaMenQrRoute>(path: '/add/qr')
class DenpaMenQrRoute extends GoRouteData with $DenpaMenQrRoute {
  const DenpaMenQrRoute({this.$extra});

  final DenpaMenQrPageArgs? $extra;

  @override
  Widget build(BuildContext context, GoRouterState state) => DenpaMenQrPage(
    masterData: $extra!.masterData,
    initialRawValue: $extra!.initialRawValue,
  );
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

/// Pushed (never `go`-navigated to) from [EditableParents] to pick which
/// individuals become [DenpaMen.parentIds]. Declared outside
/// [AppShellRouteData] for the same reason as [SearchResultsRoute].
/// [$extra] carries the args both this page and [DenpaMenSelectionSearchRoute]
/// need, since neither can round-trip through a URL.
@TypedGoRoute<DenpaMenSelectionRoute>(path: '/select')
class DenpaMenSelectionRoute extends GoRouteData with $DenpaMenSelectionRoute {
  const DenpaMenSelectionRoute({this.$extra});

  final DenpaMenSelectionArgs? $extra;

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      DenpaMenSelectionPage(args: $extra!);
}

/// Pushed from [DenpaMenSelectionPage]'s search tab once the user runs a
/// search. Declared outside [AppShellRouteData] for the same reason as
/// [SearchResultsRoute]; unlike it, tapping a result here toggles a
/// selection instead of opening a preview, and the header checkmark pops
/// this route with `true` to let [DenpaMenSelectionPage] finish the flow.
@TypedGoRoute<DenpaMenSelectionSearchRoute>(path: '/select/search')
class DenpaMenSelectionSearchRoute extends GoRouteData
    with $DenpaMenSelectionSearchRoute {
  const DenpaMenSelectionSearchRoute({this.$extra});

  final DenpaMenSelectionArgs? $extra;

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      DenpaMenSelectionSearchResults(
        excludeId: $extra!.excludeId,
        maxSelectable: $extra!.maxSelectable,
      );
}

/// Pushed from the edit panel's "record monster exp" tile. Declared
/// outside [AppShellRouteData] for the same reason as [SearchResultsRoute].
/// [$extra] carries the currently-recorded [MonsterExp], if any, so the
/// page can be reopened pre-filled with it.
@TypedGoRoute<MonsterExpRoute>(path: '/monster-exp')
class MonsterExpRoute extends GoRouteData with $MonsterExpRoute {
  const MonsterExpRoute({this.$extra});

  final MonsterExp? $extra;

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      MonsterExpPage(initial: $extra);
}

/// Pushed from [MonsterExpPage]'s "defeated monster" field to pick which
/// [Monster] was defeated. Declared outside [AppShellRouteData] for the
/// same reason as [SearchResultsRoute].
@TypedGoRoute<MonsterSelectionRoute>(path: '/monster-exp/select')
class MonsterSelectionRoute extends GoRouteData with $MonsterSelectionRoute {
  const MonsterSelectionRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      const MonsterSelectionPage();
}

/// Pushed from the home list's per-individual menu when that individual has
/// parents: walks its ancestry backward, guiding the user through catching
/// and breeding the individuals needed to reach it again.
@TypedGoRoute<BirthGuideRoute>(path: '/birth-guide')
class BirthGuideRoute extends GoRouteData with $BirthGuideRoute {
  const BirthGuideRoute({this.$extra});

  final BirthGuideArgs? $extra;

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      BirthGuidePage(masterData: $extra!.masterData, target: $extra!.target);
}

/// Pushed from the settings list's "account" tile.
@TypedGoRoute<AccountSettingsRoute>(path: '/settings/account')
class AccountSettingsRoute extends GoRouteData with $AccountSettingsRoute {
  const AccountSettingsRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      const AccountSettingsPage();
}

/// Pushed from the settings list's "theme" tile.
@TypedGoRoute<ThemeSettingsRoute>(path: '/settings/theme')
class ThemeSettingsRoute extends GoRouteData with $ThemeSettingsRoute {
  const ThemeSettingsRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      const ThemeSettingsPage();
}

/// Pushed from the settings list's "clipping" tile.
@TypedGoRoute<ClippingSettingsRoute>(path: '/settings/clipping')
class ClippingSettingsRoute extends GoRouteData with $ClippingSettingsRoute {
  const ClippingSettingsRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      const ClippingSettingsPage();
}

/// Pushed from the settings list's "language" tile.
@TypedGoRoute<LanguageSettingsRoute>(path: '/settings/language')
class LanguageSettingsRoute extends GoRouteData with $LanguageSettingsRoute {
  const LanguageSettingsRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      const LanguageSettingsPage();
}

/// Pushed from the settings list's "open source licenses" tile.
@TypedGoRoute<OpenSourceLicensesRoute>(path: '/settings/licenses')
class OpenSourceLicensesRoute extends GoRouteData
    with $OpenSourceLicensesRoute {
  const OpenSourceLicensesRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      const OpenSourceLicensesPage();
}

/// Pushed from the settings list's "data management" tile.
@TypedGoRoute<DataManagementRoute>(path: '/settings/data')
class DataManagementRoute extends GoRouteData with $DataManagementRoute {
  const DataManagementRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      const DataManagementPage();
}

/// Pushed from the settings list's "developer" section, debug builds only.
/// Lists every antenna category (see `PhysiqueTableListPage`), from which a
/// level is picked before pushing [PhysiqueTableViewRoute].
@TypedGoRoute<PhysiqueTableListRoute>(path: '/settings/developer/physiques')
class PhysiqueTableListRoute extends GoRouteData with $PhysiqueTableListRoute {
  const PhysiqueTableListRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      const PhysiqueTableListPage();
}

/// Pushed from [PhysiqueTableListPage] once a level/antenna category pair
/// is chosen. `$extra` carries that pair, since it can't round-trip
/// through a URL (see [DenpaMenSelectionRoute] for the same pattern).
@TypedGoRoute<PhysiqueTableViewRoute>(
  path: '/settings/developer/physiques/view',
)
class PhysiqueTableViewRoute extends GoRouteData with $PhysiqueTableViewRoute {
  const PhysiqueTableViewRoute({required this.$extra});

  final PhysiqueTableArgs $extra;

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      PhysiqueTableViewPage(args: $extra);
}

/// Pushed from [PhysiqueTableViewPage]'s edit button.
@TypedGoRoute<PhysiqueTableEditRoute>(
  path: '/settings/developer/physiques/edit',
)
class PhysiqueTableEditRoute extends GoRouteData with $PhysiqueTableEditRoute {
  const PhysiqueTableEditRoute({required this.$extra});

  final PhysiqueTableArgs $extra;

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      PhysiqueTableEditPage(args: $extra);
}

/// Wraps the cloud backup page and its history page in [CloudBackupShell],
/// marking the pair as always-poppable so [AppScaffold] shows a back
/// button on both, matching the "poppable subpage" tier: own header, back
/// button, no bottom navigation bar. Declared as a top-level route (a
/// sibling of [AppShellRouteData], not nested inside it).
@TypedShellRoute<CloudBackupShellRouteData>(
  routes: [
    TypedGoRoute<CloudBackupRoute>(path: '/settings/cloud-backup'),
    TypedGoRoute<CloudBackupHistoryRoute>(
      path: '/settings/cloud-backup/history',
    ),
  ],
)
class CloudBackupShellRouteData extends ShellRouteData {
  const CloudBackupShellRouteData();

  @override
  Widget builder(BuildContext context, GoRouterState state, Widget navigator) =>
      CloudBackupShell(child: navigator);
}

/// Pushed from the settings list's "cloud backup" tile.
class CloudBackupRoute extends GoRouteData with $CloudBackupRoute {
  const CloudBackupRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      const CloudBackupPage();
}

/// Pushed from the cloud backup page's history FAB.
class CloudBackupHistoryRoute extends GoRouteData
    with $CloudBackupHistoryRoute {
  const CloudBackupHistoryRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      const CloudBackupHistoryPage();
}
