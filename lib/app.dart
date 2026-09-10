import 'package:flutter/gestures.dart' show PointerDeviceKind;
import 'package:flutter/material.dart';

import 'package:croppy/croppy.dart';
import 'package:data_cache/data_cache.dart';
import 'package:data_pack/data_pack.dart';
import 'package:denpamemo_widgets/denpamemo_widgets.dart' as denpamemo_widgets;
import 'package:flutter_build_tracker/flutter_build_tracker.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/misc.dart' show Override;
import 'package:go_router/go_router.dart';
import 'package:graphql_client/graphql_client.dart';
import 'package:step_dialog/step_dialog.dart' as step_dialog;

import 'data/objectbox/objectbox.dart';
import 'i18n/gen/strings.g.dart';
import 'l10n/croppy_localizations_ja.dart';
import 'logging/build_tracker_bridge.dart';
import 'notifications/app_notification_handler.dart';
import 'providers/app_initialization_providers.dart';
import 'providers/app_notification_providers.dart';
import 'providers/app_settings_providers.dart';
import 'providers/backend_connection_settings_providers.dart';
import 'providers/cloud_account_providers.dart';
import 'providers/network_providers.dart';
import 'providers/objectbox_providers.dart';
import 'routing/app_router.dart';
import 'theme/app_theme.dart';
import 'theme/app_theme_mode_mapping.dart';
import 'widgets/restart_widget.dart';
import 'widgets/splash/native_splash.dart';
import 'widgets/splash/splash_gate.dart';

/// Root widget wiring the app's translation providers, restart boundary,
/// and Riverpod [ProviderScope] around [_ThemedMaterialApp], overriding
/// [objectBoxProvider] and [dataCacheProvider] with the instances created
/// during startup.
class MyApp extends StatelessWidget {
  const MyApp({
    super.key,
    required this.objectBox,
    required this.cacheIndexRepository,
    this.overrides = const [],
  });

  final ObjectBox objectBox;
  final CacheIndexRepository cacheIndexRepository;
  final List<Override> overrides;

  @override
  Widget build(BuildContext context) {
    return denpamemo_widgets.TranslationProvider(
      child: step_dialog.TranslationProvider(
        child: TranslationProvider(
          child: RestartWidget(
            child: ProviderScope(
              overrides: [
                objectBoxProvider.overrideWithValue(objectBox),
                dataCacheProvider.overrideWithValue(cacheIndexRepository),
                denpamemo_widgets.signInStatusProvider.overrideWith(
                  (ref) => ref.watch(cloudAccountProvider).isSignedIn,
                ),
                graphQLClientProvider.overrideWith(
                  (ref) => GraphQlClientFactory(
                    endpoint: ref
                        .watch(backendConnectionSettingsProvider)
                        .graphQlEndpoint,
                  ).create(dio: ref.watch(sharedDioProvider)),
                ),
                ...overrides,
              ],
              child: const _ThemedMaterialApp(),
            ),
          ),
        ),
      ),
    );
  }
}

class _ThemedMaterialApp extends ConsumerStatefulWidget {
  const _ThemedMaterialApp();

  @override
  ConsumerState<_ThemedMaterialApp> createState() => _ThemedMaterialAppState();
}

class _ThemedMaterialAppState extends ConsumerState<_ThemedMaterialApp> {
  late final GoRouter _router = createAppRouter();

  @override
  Widget build(BuildContext context) {
    final mainScreenReady = !ref.watch(appInitializationProvider).isLoading;
    ref.listen(appInitializationProvider, (previous, next) {
      if (!next.isLoading) signalNativeSplashReady();
    });
    ref.listen<List<AppNotification>>(appNotificationsProvider, (
      previous,
      next,
    ) {
      handleAppNotificationTransitions(
        ref,
        _router.routerDelegate.navigatorKey,
        previous,
        next,
      );
    });
    final settings = ref.watch(appSettingsProvider);
    final themeMode = settings.themeMode;
    return MaterialApp.router(
      title: t.app.name,
      scrollBehavior: const _DragAnywhereScrollBehavior(),
      theme: AppLightTheme.forContrast(settings.contrastLevel),
      darkTheme: AppDarkTheme.forContrast(settings.contrastLevel),
      themeMode: themeMode.toFlutterThemeMode(),
      routerConfig: _router,
      builder: (context, child) {
        final splashGate = denpamemo_widgets.ResponsiveScope(
          child: SplashGate(ready: mainScreenReady, child: child!),
        );
        return settings.buildTrackerEnabled
            ? BuildTracker(
                name: splashGate.runtimeType.toString(),
                controller: buildTrackerController,
                showOverlay: false,
                logToConsole: false,
                child: splashGate,
              )
            : splashGate;
      },
      localizationsDelegates: const [
        CroppyLocalizationsJa.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        CroppyLocalizations.delegate,
      ],
      supportedLocales: const [Locale('ja')],
    );
  }
}

/// Makes [MaterialScrollBehavior] treat the mouse as a drag device, so
/// pointer-drag gestures — including the overscroll `RefreshIndicator`
/// needs for pull-to-refresh — fire from a mouse on desktop/web, where
/// Flutter's default excludes it.
class _DragAnywhereScrollBehavior extends MaterialScrollBehavior {
  const _DragAnywhereScrollBehavior();

  @override
  Set<PointerDeviceKind> get dragDevices => {
    ...super.dragDevices,
    PointerDeviceKind.mouse,
  };
}
