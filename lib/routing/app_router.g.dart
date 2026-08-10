// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_router.dart';

// **************************************************************************
// GoRouterGenerator
// **************************************************************************

List<RouteBase> get $appRoutes => [
  $homeRoute,
  $settingsRoute,
  $addDenpaMenRoute,
  $denpaMenQrRoute,
  $qrCodeSelectionRoute,
  $birthGuideRoute,
];

RouteBase get $homeRoute => GoRouteData.$route(
  path: '/',
  hasOverriddenOnExit: false,
  factory: $HomeRoute._fromState,
);

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

RouteBase get $settingsRoute => GoRouteData.$route(
  path: '/settings',
  hasOverriddenOnExit: false,
  factory: $SettingsRoute._fromState,
);

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
      DenpaMenQrRoute($extra: state.extra as MasterData?);

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
