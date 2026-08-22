import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/misc.dart' show Override;

import 'data/denpa_men/objectbox_denpa_men_repository.dart';
import 'data/master_data/graphql_master_data_repository.dart';
import 'data/objectbox/objectbox.dart';
import 'domain/denpa_men/denpa_men_hash_migration.dart';
import 'i18n/gen/strings.g.dart';
import 'providers/graphql_client_provider.dart';
import 'providers/objectbox_providers.dart';
import 'routing/app_router.dart';

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

  /// Additional provider overrides layered on top of [objectBoxProvider]'s.
  /// Lets tests substitute a fast in-memory/file-backed
  /// `masterDataRepositoryProvider` for the real GraphQL-backed one,
  /// without needing a running `modules/server` instance.
  final List<Override> overrides;

  @override
  Widget build(BuildContext context) {
    return TranslationProvider(
      child: ProviderScope(
        overrides: [
          objectBoxProvider.overrideWithValue(objectBox),
          ...overrides,
        ],
        child: MaterialApp.router(
          title: t.app.name,
          theme: ThemeData(
            colorScheme: .fromSeed(seedColor: Colors.deepPurple),
          ),
          routerConfig: appRouter,
        ),
      ),
    );
  }
}
