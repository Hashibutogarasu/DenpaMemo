import 'package:data_pack/data_pack.dart';
import 'package:denpamemo_widgets/denpamemo_widgets.dart' as denpamemo_widgets;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/misc.dart' show Override;
import 'package:graphql_client/graphql_client.dart';
import 'package:step_dialog/step_dialog.dart' as step_dialog;

import 'data/denpa_men/objectbox_denpa_men_repository.dart';
import 'data/objectbox/objectbox.dart';
import 'i18n/gen/strings.g.dart';
import 'providers/app_settings_providers.dart';
import 'providers/objectbox_providers.dart';
import 'routing/app_router.dart';
import 'theme/app_theme_mode_mapping.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final objectBox = await ObjectBox.create();
  await _migrateDenpaMenHashesIfServerReachable(objectBox);
  runApp(MyApp(objectBox: objectBox));
}

/// The hash migration needs master data before any [ProviderScope] exists
/// to read it from `masterDataProvider`, so it builds its own
/// [GraphQLClient] via [GraphQlClientFactory]. Master data now requires
/// the `modules/server` API, unlike the bundled-JSON repository this
/// replaced; if it isn't reachable yet, skip the migration rather than
/// crash the app before it can even show its own error screen.
Future<void> _migrateDenpaMenHashesIfServerReachable(
  ObjectBox objectBox,
) async {
  try {
    final masterData = await GraphqlMasterDataRepository(
      client: graphQlClientFactory.create(),
    ).load();
    migrateDenpaMenHashes(ObjectBoxDenpaMenRepository(objectBox), masterData);
  } catch (error) {
    debugPrint('Skipping hash migration: master data unavailable ($error)');
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key, required this.objectBox, this.overrides = const []});

  final ObjectBox objectBox;
  final List<Override> overrides;

  @override
  Widget build(BuildContext context) {
    return denpamemo_widgets.TranslationProvider(
      child: step_dialog.TranslationProvider(
        child: TranslationProvider(
          child: ProviderScope(
            overrides: [
              objectBoxProvider.overrideWithValue(objectBox),
              ...overrides,
            ],
            child: const _ThemedMaterialApp(),
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
    final themeMode = ref.watch(appSettingsProvider).themeMode;
    return MaterialApp.router(
      title: t.app.name,
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
