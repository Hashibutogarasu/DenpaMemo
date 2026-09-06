import 'package:api_client/api_client.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/physique_table/objectbox_physique_table_cache_repository.dart';
import 'physique_table_cache_providers.dart';
import 'physiques_providers.dart';

/// Pulls every registered physique table type's rows from `modules/server`
/// at app startup into [PhysiqueTableCacheRepository], so the physique
/// table editor works offline. Never throws: an unreachable server just
/// leaves whatever is already cached as-is.
class PhysiqueTableSyncService {
  const PhysiqueTableSyncService({
    required this.client,
    required this.cacheRepository,
  });

  final PhysiquesApiClient client;
  final PhysiqueTableCacheRepository cacheRepository;

  /// Fetches and caches every table's rows for each of [types], yielding
  /// to the event loop between types so a large prefetch never blocks a
  /// frame.
  Future<void> prefetch(List<TableDefinition> types) async {
    for (final type in types) {
      try {
        final records = await client.fetch(type: type.type);
        cacheRepository.upsertFromServer(type.type, records);
      } catch (_) {
        // Server unreachable for this type: keep whatever is already cached.
      }
      await Future(() {});
    }
  }
}

final physiqueTableSyncServiceProvider = Provider<PhysiqueTableSyncService>((
  ref,
) {
  return PhysiqueTableSyncService(
    client: ref.watch(physiquesApiClientProvider),
    cacheRepository: ref.watch(physiqueTableCacheRepositoryProvider),
  );
});

/// Runs [PhysiqueTableSyncService.prefetch] once at app launch, watched
/// alongside `appInitializationProvider` in `lib/main.dart`.
final physiqueTableInitializationProvider = FutureProvider<void>((ref) async {
  final service = ref.watch(physiqueTableSyncServiceProvider);
  final types = await ref.watch(tableTypesProvider.future);
  await service.prefetch(types);
});
