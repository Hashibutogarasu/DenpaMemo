import 'package:api_client/api_client.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../config/physique_server_config.dart';
import 'physique_table_cache_providers.dart';

final physiquesApiClientProvider = Provider<PhysiquesApiClient>(
  (ref) => PhysiquesApiClient(Uri.parse(physiqueServerConfig.baseUrl)),
);

/// Every registered table type (see `GET /tables/types`), so the app never
/// hardcodes which physique table types (HP, speed, ...) exist.
final tableTypesProvider = FutureProvider<List<TableDefinition>>((ref) async {
  final client = ref.watch(physiquesApiClientProvider);
  return client.fetchTypes();
});

/// Every `anntenaCategory` that has at least one cached row, across every
/// registered table type. Used by [PhysiqueTableListPage] to decide which
/// antenna categories show an edit shortcut. Reads the local cache rather
/// than the server, so it never hangs or errors while offline.
final physiqueTableAnntenaCategoriesWithDataProvider = Provider<Set<String>>(
  (ref) => ref
      .watch(physiqueTableCacheRepositoryProvider)
      .anntenaCategoriesWithData(),
);
