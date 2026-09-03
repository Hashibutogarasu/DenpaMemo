import 'dart:convert';

import 'package:data_cache/data_cache.dart';
import 'package:denpamemo_widgets/denpamemo_widgets.dart' as denpamemo_widgets;
import 'package:firebase_sign_in/firebase_sign_in.dart';
import 'package:flutter/gestures.dart' show PointerDeviceKind;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/misc.dart' show Override;
import 'package:intl/date_symbol_data_local.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:step_dialog/step_dialog.dart' as step_dialog;

import 'data/objectbox/objectbox.dart';
import 'i18n/gen/strings.g.dart';
import 'providers/app_settings_providers.dart';
import 'providers/denpa_men_sync_providers.dart';
import 'providers/objectbox_providers.dart';
import 'routing/app_router.dart';
import 'theme/app_theme_mode_mapping.dart';
import 'widgets/restart_widget.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDateFormatting();
  final packageInfo = await PackageInfo.fromPlatform();
  final objectBox = await ObjectBox.create();
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
    ref.watch(denpaMenSyncProvider);
    final themeMode = ref.watch(appSettingsProvider).themeMode;
    return MaterialApp.router(
      title: t.app.name,
      scrollBehavior: const _DragAnywhereScrollBehavior(),
      theme: appLightTheme,
      darkTheme: appDarkTheme,
      themeMode: themeMode.toFlutterThemeMode(),
      routerConfig: appRouter,
    );
  }
}

final ThemeData appLightTheme = ThemeData(
  colorScheme: .fromSeed(seedColor: Colors.deepPurple),
  elevatedButtonTheme: _elevatedButtonTheme,
  extensions: _themeExtensions,
);

final ThemeData appDarkTheme = ThemeData(
  colorScheme: .fromSeed(
    seedColor: Colors.deepPurple,
    brightness: Brightness.dark,
  ),
  elevatedButtonTheme: _elevatedButtonTheme,
  extensions: _themeExtensions,
);

/// Shared between light/dark: [AppBackButton] and every other
/// [ElevatedButton] in the app get this shape/size, with colors resolved
/// from each [ThemeData]'s own [ColorScheme]. [AppBackButton.height] must
/// match this style's `minimumSize` height.
final ElevatedButtonThemeData _elevatedButtonTheme = ElevatedButtonThemeData(
  style: ElevatedButton.styleFrom(
    shape: const StadiumBorder(),
    minimumSize: const Size(64, denpamemo_widgets.AppBackButton.height),
  ),
);

/// Shared between light/dark for now — these extensions' colors/animations
/// don't currently vary by brightness (unlike [ColorScheme], which each
/// [ThemeData] above derives separately via `.fromSeed`).
final _themeExtensions = <ThemeExtension<dynamic>>[
  const denpamemo_widgets.SlantedHeaderThemeData(
    fillColor: Color(0xFF52BBE5),
    borderColor: Color(0xFF0865C2),
    borderWidth: 6,
    angleDegrees: 10,
    contentPadding: EdgeInsets.only(left: 20, top: 8, right: 8),
  ),
  const denpamemo_widgets.FabButtonThemeData(
    barrierColor: Colors.black54,
    scrimAnimationDuration: Duration(milliseconds: 200),
    scrimAnimationCurve: Curves.easeOutCubic,
    mainButtonAnimationDuration: Duration(milliseconds: 200),
    miniOptionSlideCurve: Curves.easeOutCubic,
    miniOptionSlideOffset: Offset(0, 0.3),
    labelBubbleElevation: 4,
    labelBubbleBorderRadius: 8,
    labelBubblePadding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
    miniOptionGap: 12,
    miniOptionRowBottomPadding: 12,
  ),
  const denpamemo_widgets.DenpaMenContainerThemeData(
    statusBackgroundColor: Color(0xFF90E2FF),
    statusBorderRadius: 20,
    nestedBackgroundColor: Color(0xFFC8E0E7),
    nestedBorderColor: Color(0xFF90DAFE),
    nestedBorderWidth: 2,
    nestedBorderRadius: 20,
    accentColor: Color(0xFF056193),
    memoBackgroundColor: Colors.white,
    memoBorderRadius: 4,
    headerDividerHeight: 2,
    pencilIconSize: 28,
    previewIconSize: 56,
    accordionIconSize: 32,
    accordionTitleFontSize: 20,
    accordionCheckboxSlotSize: 40,
    accordionAnimationDuration: Duration(milliseconds: 200),
    resistanceGap: 5,
  ),
  const denpamemo_widgets.DenpaMenLabelThemeData(
    headerTitleOutlineColor: Color(0xFF238BCB),
    pillBackgroundColor: Color(0xFF7FC9FF),
    pillTextColor: Color(0xFF2B2031),
    expBarFilledColor: Color(0xFFFFEB3B),
    expBarUnfilledColor: Color(0xFF056193),
    maxedValueColor: Color(0xFF7BEA95),
    inactiveBonusColor: Color(0xFFE53935),
  ),
];

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
