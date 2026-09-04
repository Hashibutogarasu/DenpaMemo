// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_router.dart';

// **************************************************************************
// GoRouterGenerator
// **************************************************************************

List<RouteBase> get $appRoutes => [
  $appShellRouteData,
  $searchResultsRoute,
  $addDenpaMenRoute,
  $denpaMenQrRoute,
  $qrCodeSelectionRoute,
  $denpaMenSelectionRoute,
  $denpaMenSelectionSearchRoute,
  $monsterExpRoute,
  $monsterSelectionRoute,
  $birthGuideRoute,
  $accountSettingsRoute,
  $themeSettingsRoute,
  $clippingSettingsRoute,
  $languageSettingsRoute,
  $openSourceLicensesRoute,
  $dataManagementRoute,
  $physiqueTableListRoute,
  $physiqueTableViewRoute,
  $physiqueTableEditRoute,
  $cloudBackupShellRouteData,
];

RouteBase get $appShellRouteData => ShellRouteData.$route(
  factory: $AppShellRouteDataExtension._fromState,
  routes: [
    GoRouteData.$route(
      path: '/',
      hasOverriddenOnExit: false,
      factory: $HomeRoute._fromState,
    ),
    GoRouteData.$route(
      path: '/settings',
      hasOverriddenOnExit: false,
      factory: $SettingsRoute._fromState,
    ),
    GoRouteData.$route(
      path: '/search',
      hasOverriddenOnExit: false,
      factory: $SearchRoute._fromState,
    ),
    GoRouteData.$route(
      path: '/analysis',
      hasOverriddenOnExit: false,
      factory: $AnalysisRoute._fromState,
    ),
  ],
);

extension $AppShellRouteDataExtension on AppShellRouteData {
  static AppShellRouteData _fromState(GoRouterState state) =>
      const AppShellRouteData();
}

mixin $HomeRoute on GoRouteData {
  static HomeRoute _fromState(GoRouterState state) => const HomeRoute();

  @override
  String get location => GoRouteData.$location('/');

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

mixin $SettingsRoute on GoRouteData {
  static SettingsRoute _fromState(GoRouterState state) => const SettingsRoute();

  @override
  String get location => GoRouteData.$location('/settings');

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

mixin $SearchRoute on GoRouteData {
  static SearchRoute _fromState(GoRouterState state) => const SearchRoute();

  @override
  String get location => GoRouteData.$location('/search');

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

mixin $AnalysisRoute on GoRouteData {
  static AnalysisRoute _fromState(GoRouterState state) => const AnalysisRoute();

  @override
  String get location => GoRouteData.$location('/analysis');

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $searchResultsRoute => GoRouteData.$route(
  path: '/search/results',
  hasOverriddenOnExit: false,
  factory: $SearchResultsRoute._fromState,
);

mixin $SearchResultsRoute on GoRouteData {
  static SearchResultsRoute _fromState(GoRouterState state) =>
      const SearchResultsRoute();

  @override
  String get location => GoRouteData.$location('/search/results');

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $addDenpaMenRoute => GoRouteData.$route(
  path: '/add',
  hasOverriddenOnExit: false,
  factory: $AddDenpaMenRoute._fromState,
);

mixin $AddDenpaMenRoute on GoRouteData {
  static AddDenpaMenRoute _fromState(GoRouterState state) =>
      AddDenpaMenRoute($extra: state.extra as DenpaMenEditorArgs?);

  AddDenpaMenRoute get _self => this as AddDenpaMenRoute;

  @override
  String get location => GoRouteData.$location('/add');

  @override
  void go(BuildContext context) => context.go(location, extra: _self.$extra);

  @override
  Future<T?> push<T>(BuildContext context) =>
      context.push<T>(location, extra: _self.$extra);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location, extra: _self.$extra);

  @override
  void replace(BuildContext context) =>
      context.replace(location, extra: _self.$extra);
}

RouteBase get $denpaMenQrRoute => GoRouteData.$route(
  path: '/add/qr',
  hasOverriddenOnExit: false,
  factory: $DenpaMenQrRoute._fromState,
);

mixin $DenpaMenQrRoute on GoRouteData {
  static DenpaMenQrRoute _fromState(GoRouterState state) =>
      DenpaMenQrRoute($extra: state.extra as DenpaMenQrPageArgs?);

  DenpaMenQrRoute get _self => this as DenpaMenQrRoute;

  @override
  String get location => GoRouteData.$location('/add/qr');

  @override
  void go(BuildContext context) => context.go(location, extra: _self.$extra);

  @override
  Future<T?> push<T>(BuildContext context) =>
      context.push<T>(location, extra: _self.$extra);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location, extra: _self.$extra);

  @override
  void replace(BuildContext context) =>
      context.replace(location, extra: _self.$extra);
}

RouteBase get $qrCodeSelectionRoute => GoRouteData.$route(
  path: '/add/qr-select',
  hasOverriddenOnExit: false,
  factory: $QrCodeSelectionRoute._fromState,
);

mixin $QrCodeSelectionRoute on GoRouteData {
  static QrCodeSelectionRoute _fromState(GoRouterState state) =>
      QrCodeSelectionRoute($extra: state.extra as MasterData?);

  QrCodeSelectionRoute get _self => this as QrCodeSelectionRoute;

  @override
  String get location => GoRouteData.$location('/add/qr-select');

  @override
  void go(BuildContext context) => context.go(location, extra: _self.$extra);

  @override
  Future<T?> push<T>(BuildContext context) =>
      context.push<T>(location, extra: _self.$extra);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location, extra: _self.$extra);

  @override
  void replace(BuildContext context) =>
      context.replace(location, extra: _self.$extra);
}

RouteBase get $denpaMenSelectionRoute => GoRouteData.$route(
  path: '/select',
  hasOverriddenOnExit: false,
  factory: $DenpaMenSelectionRoute._fromState,
);

mixin $DenpaMenSelectionRoute on GoRouteData {
  static DenpaMenSelectionRoute _fromState(GoRouterState state) =>
      DenpaMenSelectionRoute($extra: state.extra as DenpaMenSelectionArgs?);

  DenpaMenSelectionRoute get _self => this as DenpaMenSelectionRoute;

  @override
  String get location => GoRouteData.$location('/select');

  @override
  void go(BuildContext context) => context.go(location, extra: _self.$extra);

  @override
  Future<T?> push<T>(BuildContext context) =>
      context.push<T>(location, extra: _self.$extra);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location, extra: _self.$extra);

  @override
  void replace(BuildContext context) =>
      context.replace(location, extra: _self.$extra);
}

RouteBase get $denpaMenSelectionSearchRoute => GoRouteData.$route(
  path: '/select/search',
  hasOverriddenOnExit: false,
  factory: $DenpaMenSelectionSearchRoute._fromState,
);

mixin $DenpaMenSelectionSearchRoute on GoRouteData {
  static DenpaMenSelectionSearchRoute _fromState(GoRouterState state) =>
      DenpaMenSelectionSearchRoute(
        $extra: state.extra as DenpaMenSelectionArgs?,
      );

  DenpaMenSelectionSearchRoute get _self =>
      this as DenpaMenSelectionSearchRoute;

  @override
  String get location => GoRouteData.$location('/select/search');

  @override
  void go(BuildContext context) => context.go(location, extra: _self.$extra);

  @override
  Future<T?> push<T>(BuildContext context) =>
      context.push<T>(location, extra: _self.$extra);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location, extra: _self.$extra);

  @override
  void replace(BuildContext context) =>
      context.replace(location, extra: _self.$extra);
}

RouteBase get $monsterExpRoute => GoRouteData.$route(
  path: '/monster-exp',
  hasOverriddenOnExit: false,
  factory: $MonsterExpRoute._fromState,
);

mixin $MonsterExpRoute on GoRouteData {
  static MonsterExpRoute _fromState(GoRouterState state) =>
      MonsterExpRoute($extra: state.extra as MonsterExp?);

  MonsterExpRoute get _self => this as MonsterExpRoute;

  @override
  String get location => GoRouteData.$location('/monster-exp');

  @override
  void go(BuildContext context) => context.go(location, extra: _self.$extra);

  @override
  Future<T?> push<T>(BuildContext context) =>
      context.push<T>(location, extra: _self.$extra);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location, extra: _self.$extra);

  @override
  void replace(BuildContext context) =>
      context.replace(location, extra: _self.$extra);
}

RouteBase get $monsterSelectionRoute => GoRouteData.$route(
  path: '/monster-exp/select',
  hasOverriddenOnExit: false,
  factory: $MonsterSelectionRoute._fromState,
);

mixin $MonsterSelectionRoute on GoRouteData {
  static MonsterSelectionRoute _fromState(GoRouterState state) =>
      const MonsterSelectionRoute();

  @override
  String get location => GoRouteData.$location('/monster-exp/select');

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $birthGuideRoute => GoRouteData.$route(
  path: '/birth-guide',
  hasOverriddenOnExit: false,
  factory: $BirthGuideRoute._fromState,
);

mixin $BirthGuideRoute on GoRouteData {
  static BirthGuideRoute _fromState(GoRouterState state) =>
      BirthGuideRoute($extra: state.extra as BirthGuideArgs?);

  BirthGuideRoute get _self => this as BirthGuideRoute;

  @override
  String get location => GoRouteData.$location('/birth-guide');

  @override
  void go(BuildContext context) => context.go(location, extra: _self.$extra);

  @override
  Future<T?> push<T>(BuildContext context) =>
      context.push<T>(location, extra: _self.$extra);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location, extra: _self.$extra);

  @override
  void replace(BuildContext context) =>
      context.replace(location, extra: _self.$extra);
}

RouteBase get $accountSettingsRoute => GoRouteData.$route(
  path: '/settings/account',
  hasOverriddenOnExit: false,
  factory: $AccountSettingsRoute._fromState,
);

mixin $AccountSettingsRoute on GoRouteData {
  static AccountSettingsRoute _fromState(GoRouterState state) =>
      const AccountSettingsRoute();

  @override
  String get location => GoRouteData.$location('/settings/account');

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $themeSettingsRoute => GoRouteData.$route(
  path: '/settings/theme',
  hasOverriddenOnExit: false,
  factory: $ThemeSettingsRoute._fromState,
);

mixin $ThemeSettingsRoute on GoRouteData {
  static ThemeSettingsRoute _fromState(GoRouterState state) =>
      const ThemeSettingsRoute();

  @override
  String get location => GoRouteData.$location('/settings/theme');

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $clippingSettingsRoute => GoRouteData.$route(
  path: '/settings/clipping',
  hasOverriddenOnExit: false,
  factory: $ClippingSettingsRoute._fromState,
);

mixin $ClippingSettingsRoute on GoRouteData {
  static ClippingSettingsRoute _fromState(GoRouterState state) =>
      const ClippingSettingsRoute();

  @override
  String get location => GoRouteData.$location('/settings/clipping');

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $languageSettingsRoute => GoRouteData.$route(
  path: '/settings/language',
  hasOverriddenOnExit: false,
  factory: $LanguageSettingsRoute._fromState,
);

mixin $LanguageSettingsRoute on GoRouteData {
  static LanguageSettingsRoute _fromState(GoRouterState state) =>
      const LanguageSettingsRoute();

  @override
  String get location => GoRouteData.$location('/settings/language');

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $openSourceLicensesRoute => GoRouteData.$route(
  path: '/settings/licenses',
  hasOverriddenOnExit: false,
  factory: $OpenSourceLicensesRoute._fromState,
);

mixin $OpenSourceLicensesRoute on GoRouteData {
  static OpenSourceLicensesRoute _fromState(GoRouterState state) =>
      const OpenSourceLicensesRoute();

  @override
  String get location => GoRouteData.$location('/settings/licenses');

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $dataManagementRoute => GoRouteData.$route(
  path: '/settings/data',
  hasOverriddenOnExit: false,
  factory: $DataManagementRoute._fromState,
);

mixin $DataManagementRoute on GoRouteData {
  static DataManagementRoute _fromState(GoRouterState state) =>
      const DataManagementRoute();

  @override
  String get location => GoRouteData.$location('/settings/data');

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $physiqueTableListRoute => GoRouteData.$route(
  path: '/settings/developer/physiques',
  hasOverriddenOnExit: false,
  factory: $PhysiqueTableListRoute._fromState,
);

mixin $PhysiqueTableListRoute on GoRouteData {
  static PhysiqueTableListRoute _fromState(GoRouterState state) =>
      const PhysiqueTableListRoute();

  @override
  String get location => GoRouteData.$location('/settings/developer/physiques');

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $physiqueTableViewRoute => GoRouteData.$route(
  path: '/settings/developer/physiques/view',
  hasOverriddenOnExit: false,
  factory: $PhysiqueTableViewRoute._fromState,
);

mixin $PhysiqueTableViewRoute on GoRouteData {
  static PhysiqueTableViewRoute _fromState(GoRouterState state) =>
      PhysiqueTableViewRoute($extra: state.extra as PhysiqueTableArgs);

  PhysiqueTableViewRoute get _self => this as PhysiqueTableViewRoute;

  @override
  String get location =>
      GoRouteData.$location('/settings/developer/physiques/view');

  @override
  void go(BuildContext context) => context.go(location, extra: _self.$extra);

  @override
  Future<T?> push<T>(BuildContext context) =>
      context.push<T>(location, extra: _self.$extra);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location, extra: _self.$extra);

  @override
  void replace(BuildContext context) =>
      context.replace(location, extra: _self.$extra);
}

RouteBase get $physiqueTableEditRoute => GoRouteData.$route(
  path: '/settings/developer/physiques/edit',
  hasOverriddenOnExit: false,
  factory: $PhysiqueTableEditRoute._fromState,
);

mixin $PhysiqueTableEditRoute on GoRouteData {
  static PhysiqueTableEditRoute _fromState(GoRouterState state) =>
      PhysiqueTableEditRoute($extra: state.extra as PhysiqueTableArgs);

  PhysiqueTableEditRoute get _self => this as PhysiqueTableEditRoute;

  @override
  String get location =>
      GoRouteData.$location('/settings/developer/physiques/edit');

  @override
  void go(BuildContext context) => context.go(location, extra: _self.$extra);

  @override
  Future<T?> push<T>(BuildContext context) =>
      context.push<T>(location, extra: _self.$extra);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location, extra: _self.$extra);

  @override
  void replace(BuildContext context) =>
      context.replace(location, extra: _self.$extra);
}

RouteBase get $cloudBackupShellRouteData => ShellRouteData.$route(
  factory: $CloudBackupShellRouteDataExtension._fromState,
  routes: [
    GoRouteData.$route(
      path: '/settings/cloud-backup',
      hasOverriddenOnExit: false,
      factory: $CloudBackupRoute._fromState,
    ),
    GoRouteData.$route(
      path: '/settings/cloud-backup/history',
      hasOverriddenOnExit: false,
      factory: $CloudBackupHistoryRoute._fromState,
    ),
  ],
);

extension $CloudBackupShellRouteDataExtension on CloudBackupShellRouteData {
  static CloudBackupShellRouteData _fromState(GoRouterState state) =>
      const CloudBackupShellRouteData();
}

mixin $CloudBackupRoute on GoRouteData {
  static CloudBackupRoute _fromState(GoRouterState state) =>
      const CloudBackupRoute();

  @override
  String get location => GoRouteData.$location('/settings/cloud-backup');

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

mixin $CloudBackupHistoryRoute on GoRouteData {
  static CloudBackupHistoryRoute _fromState(GoRouterState state) =>
      const CloudBackupHistoryRoute();

  @override
  String get location =>
      GoRouteData.$location('/settings/cloud-backup/history');

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}
