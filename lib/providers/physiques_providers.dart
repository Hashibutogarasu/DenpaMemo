import 'package:api_client/api_client.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../config/physique_server_config.dart';

final physiquesApiClientProvider = Provider<PhysiquesApiClient>(
  (ref) => PhysiquesApiClient(Uri.parse(physiqueServerConfig.baseUrl)),
);

/// Every registered table type (see `GET /tables/types`), so the app never
/// hardcodes which physique table types (HP, speed, ...) exist.
final tableTypesProvider = FutureProvider<List<TableDefinition>>((ref) async {
  final client = ref.watch(physiquesApiClientProvider);
  return client.fetchTypes();
});

/// Every `anntenaCategory` that has at least one row saved at any level,
/// across every registered table type. Used by [PhysiqueTableListPage] to
/// decide which antenna categories show an edit shortcut.
final physiqueTableAnntenaCategoriesWithDataProvider =
    FutureProvider<Set<String>>((ref) async {
      final client = ref.watch(physiquesApiClientProvider);
      final types = await ref.watch(tableTypesProvider.future);
      final result = <String>{};
      for (final type in types) {
        final records = await client.fetch(type: type.type);
        result.addAll(records.map((record) => record.anntenaCategory));
      }
      return result;
    });
