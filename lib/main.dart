import 'package:data_cache/data_cache.dart';
import 'package:denpamemo_widgets/denpamemo_widgets.dart' as denpamemo_widgets;
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/gestures.dart' show PointerDeviceKind;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/misc.dart' show Override;
import 'package:package_info_plus/package_info_plus.dart';
import 'package:step_dialog/step_dialog.dart' as step_dialog;

import 'data/objectbox/objectbox.dart';
import 'firebase_options.dart';
import 'i18n/gen/strings.g.dart';
import 'providers/app_settings_providers.dart';
import 'providers/denpa_men_sync_providers.dart';
import 'providers/objectbox_providers.dart';
import 'routing/app_router.dart';
import 'theme/app_theme_mode_mapping.dart';
import 'widgets/restart_widget.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await _initializeFirebase();
  final packageInfo = await PackageInfo.fromPlatform();
  final objectBox = await ObjectBox.create();
  final cacheIndexRepository = await CacheIndexRepository.open(
    packageInfo.packageName,
  );
  runApp(
    MyApp(objectBox: objectBox, cacheIndexRepository: cacheIndexRepository),
  );
}

/// Only the web app is registered in the Firebase console so far (see
/// [DefaultFirebaseOptions]), so this must not crash startup on platforms
/// that aren't yet configured — cloud features simply fail when used on
/// those instead.
Future<void> _initializeFirebase() async {
  try {
    await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  } on UnsupportedError {
    return;
  }
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
      theme: ThemeData(
        colorScheme: .fromSeed(seedColor: Colors.deepPurple),
      ),
      darkTheme: ThemeData(
        colorScheme: .fromSeed(
          seedColor: Colors.deepPurple,
          brightness: Brightness.dark,
        ),
      ),
      themeMode: themeMode.toFlutterThemeMode(),
      routerConfig: appRouter,
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
