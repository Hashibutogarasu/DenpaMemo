import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart' show PointerDeviceKind;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;

import 'package:app_logging/app_logging.dart';
import 'package:collection/collection.dart';
import 'package:croppy/croppy.dart';
import 'package:data_cache/data_cache.dart';
import 'package:data_pack/data_pack.dart';
import 'package:denpamemo_logics/denpamemo_logics.dart';
import 'package:denpamemo_widgets/denpamemo_widgets.dart' as denpamemo_widgets;
import 'package:dm_file/dm_file.dart';
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
import 'providers/app_notification_providers.dart';
import 'providers/app_settings_providers.dart';
import 'providers/backend_connection_settings_providers.dart';
import 'providers/cloud_account_providers.dart';
import 'providers/objectbox_providers.dart';
import 'providers/pending_operation_result_providers.dart';
import 'routing/app_router.dart';
import 'theme/app_theme.dart';
import 'theme/app_theme_mode_mapping.dart';
import 'widgets/dialog/export_complete_dialog.dart';
import 'widgets/dialog/import_complete_dialog.dart';
import 'widgets/restart_widget.dart';
import 'widgets/splash/native_splash.dart';
import 'widgets/splash/splash_gate.dart';

/// [AppNotification.kind]s whose successful completion carries an
/// [ImportResult] in [pendingOperationResultProvider].
const _importResultKinds = {'cloud_backup_restore', 'dm_import'};

/// [AppNotification.kind]s whose successful completion carries an
/// [ExportResult] in [pendingOperationResultProvider].
const _exportResultKinds = {'cloud_backup_upload', 'dm_export'};

const _resultNotificationKinds = {..._importResultKinds, ..._exportResultKinds};

/// Reacts to every [AppNotification] kind reported by the four long-running
/// operations (cloud backup upload/restore, `.dm` export/import)
/// transitioning from `running` to a terminal status, and shows the
/// matching result/error dialog via [rootNavigatorKey] — independent of
/// whichever page (if any) originally started the operation, so the result
/// still surfaces even if the user has since navigated elsewhere. Skips the
/// very first diff (app startup, [previous] is null) so a stale terminal
/// notification left over from a previous session is only cleaned up
/// silently, never displayed (its [pendingOperationResultProvider] payload
/// is long gone by then anyway, since that provider isn't persisted).
void _handleAppNotificationTransitions(
  WidgetRef ref,
  List<AppNotification>? previous,
  List<AppNotification> next,
) {
  for (final kind in _resultNotificationKinds) {
    final nextEntry = next.firstWhereOrNull((n) => n.kind == kind);
    if (nextEntry == null) continue;

    if (previous == null) {
      if (nextEntry.status != AppNotificationStatus.running) {
        ref.read(appNotificationsProvider.notifier).remove(kind);
      }
      continue;
    }

    final previousEntry = previous.firstWhereOrNull((n) => n.kind == kind);
    if (previousEntry?.status != AppNotificationStatus.running) continue;
    if (nextEntry.status == AppNotificationStatus.running) continue;

    _showResultForTransition(ref, kind, nextEntry);
    ref.read(appNotificationsProvider.notifier).remove(kind);
  }
}

void _showResultForTransition(
  WidgetRef ref,
  String kind,
  AppNotification entry,
) {
  final context = rootNavigatorKey.currentContext;
  switch (entry.status) {
    case AppNotificationStatus.completed:
      final result = ref
          .read(pendingOperationResultProvider.notifier)
          .take(kind);
      if (context == null) return;
      if (_importResultKinds.contains(kind) && result is ImportResult) {
        ImportCompleteDialog.show(context, result: result);
      } else if (_exportResultKinds.contains(kind) && result is ExportResult) {
        ExportCompleteDialog.show(context, result: result);
      }
    case AppNotificationStatus.cancelled:
      if (context == null) return;
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(t.cloudBackup.cancelled)));
    case AppNotificationStatus.failed:
      if (context == null) return;
      switch (entry.errorKind) {
        case 'not_signed_in':
          step_dialog.ErrorDialog.show(
            context,
            title: t.common.errorTitle,
            description: t.cloudBackup.notSignedInDescription,
          );
        case 'no_backup_found':
          step_dialog.ErrorDialog.show(
            context,
            title: t.common.errorTitle,
            description: t.cloudBackup.noBackupFoundDescription,
          );
        case 'dm_header_read_error':
          step_dialog.ErrorDialog.show(
            context,
            title: t.backup.importHeaderErrorTitle,
            description: t.backup.importHeaderErrorDescription,
          );
        case 'invalid_file':
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(t.home.importInvalidFile)));
        default:
          step_dialog.ErrorDialog.show(
            context,
            title: t.common.errorTitle,
            description: t.cloudBackup.networkErrorDescription(
              message: entry.message ?? '',
            ),
          );
      }
    case AppNotificationStatus.running:
      break;
  }
}

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
    ref.listen<List<AppNotification>>(appNotificationsProvider, (
      previous,
      next,
    ) {
      _handleAppNotificationTransitions(ref, previous, next);
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
