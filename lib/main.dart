import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart' show PointerDeviceKind;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;

import 'package:app_logging/app_logging.dart';
import 'package:croppy/croppy.dart';
import 'package:data_cache/data_cache.dart';
import 'package:denpamemo_logics/denpamemo_logics.dart';
import 'package:denpamemo_widgets/denpamemo_widgets.dart' as denpamemo_widgets;
import 'package:firebase_sign_in/firebase_sign_in.dart';
import 'package:flutter_build_tracker/flutter_build_tracker.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/misc.dart' show Override;
import 'package:graphql_client/graphql_client.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:step_dialog/step_dialog.dart' as step_dialog;

import 'data/objectbox/objectbox.dart';
import 'data/settings/objectbox_app_settings_repository.dart';
import 'i18n/gen/strings.g.dart';
import 'l10n/croppy_localizations_ja.dart';
import 'logging/build_tracker_bridge.dart';
import 'logging/log_file_bridge.dart';
import 'providers/app_initialization_providers.dart';
import 'providers/app_settings_providers.dart';
import 'providers/backend_connection_settings_providers.dart';
import 'providers/cloud_account_providers.dart';
import 'providers/objectbox_providers.dart';
import 'routing/app_router.dart';
import 'theme/app_theme.dart';
import 'theme/app_theme_mode_mapping.dart';
import 'widgets/restart_widget.dart';
import 'widgets/splash/native_splash.dart';
import 'widgets/splash/splash_gate.dart';

void main() {
  runZonedWithPrintInterceptor(_main);
}

Future<void> _main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await RustLib.init();

  if (kDebugMode) {
    installDebugPrintInterceptor();
    installBuildTrackerBridge();
    await installLogFileWriter();
  }

  await initializeDateFormatting();
  final packageInfo = await PackageInfo.fromPlatform();
  final objectBox = await ObjectBox.create();

  if (kDebugMode) {
    debugPrintRebuildDirtyWidgets = ObjectBoxAppSettingsRepository(
      objectBox,
    ).get().buildTrackerEnabled;
  }
  final cacheIndexRepository = await CacheIndexRepository.open(
    packageInfo.packageName,
  );
  final googleOAuthClientConfig = await _loadGoogleOAuthClientConfig();
  final container = ProviderContainer(
    overrides: [
      objectBoxProvider.overrideWithValue(objectBox),
      dataCacheProvider.overrideWithValue(cacheIndexRepository),
      googleOAuthClientConfigProvider.overrideWithValue(
        googleOAuthClientConfig,
      ),
    ],
  );
  await container.read(firebaseSignInProvider.future);
  runApp(
    MyApp(
      objectBox: objectBox,
      cacheIndexRepository: cacheIndexRepository,
      overrides: [
        googleOAuthClientConfigProvider.overrideWithValue(
          googleOAuthClientConfig,
        ),
      ],
    ),
  );
}

/// Loads the Google OAuth "Desktop app" client config used by
/// [RestFirebaseSignInBackend]'s Google sign-in loopback flow — bundled as
/// an asset rather than checked into source (see `.gitignore`).
Future<GoogleOAuthClientConfig> _loadGoogleOAuthClientConfig() async {
  final raw = await rootBundle.loadString(
    'assets/config/auth/google/google_client_secrets.json',
  );
  return GoogleOAuthClientConfig.fromInstalledAppJson(
    jsonDecode(raw) as Map<String, dynamic>,
  );
}

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
                  ).create(loggingLink: LoggingGraphQLLink()),
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

class _ThemedMaterialApp extends ConsumerWidget {
  const _ThemedMaterialApp();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final mainScreenReady = !ref.watch(appInitializationProvider).isLoading;
    ref.listen(appInitializationProvider, (previous, next) {
      if (!next.isLoading) signalNativeSplashReady();
    });
    final settings = ref.watch(appSettingsProvider);
    final themeMode = settings.themeMode;
    return MaterialApp.router(
      title: t.app.name,
      scrollBehavior: const _DragAnywhereScrollBehavior(),
      theme: AppLightTheme.forContrast(settings.contrastLevel),
      darkTheme: AppDarkTheme.forContrast(settings.contrastLevel),
      themeMode: themeMode.toFlutterThemeMode(),
      routerConfig: appRouter,
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

/// [MaterialScrollBehavior] additionally treats the mouse as a drag
/// device. Without this, pointer-drag gestures — including the overscroll
/// `RefreshIndicator` needs for pull-to-refresh — never fire from a mouse
/// on desktop/web, since Flutter's default excludes it (to leave mouse
/// drags free for text selection).
class _DragAnywhereScrollBehavior extends MaterialScrollBehavior {
  const _DragAnywhereScrollBehavior();

  @override
  Set<PointerDeviceKind> get dragDevices => {
    ...super.dragDevices,
    PointerDeviceKind.mouse,
  };
}
