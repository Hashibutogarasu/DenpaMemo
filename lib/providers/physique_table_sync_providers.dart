import 'package:api_client/api_client.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/physique_table/objectbox_physique_table_cache_repository.dart';
import 'physique_table_cache_providers.dart';
import 'physiques_providers.dart';

/// Pulls every registered physique table type's rows from `modules/server`
/// into [PhysiqueTableCacheRepository], so the physique table editor and
/// offline identification work without it. Never throws and never blocks
/// past [timeout] per type: an unreachable or slow-to-respond server just
/// leaves whatever is already cached as-is.
class PhysiqueTableSyncService {
  const PhysiqueTableSyncService({
    required this.client,
    required this.cacheRepository,
    this.timeout = const Duration(seconds: 5),
  });

  final PhysiquesApiClient client;
  final PhysiqueTableCacheRepository cacheRepository;
  final Duration timeout;

  /// Fetches and caches every table's rows for each of [types], yielding
  /// to the event loop between types so a large prefetch never blocks a
  /// frame.
  Future<void> prefetch(List<TableDefinition> types) async {
    for (final type in types) {
      try {
        final records = await client.fetch(type: type.type).timeout(timeout);
        cacheRepository.upsertFromServer(type.type, records);
      } catch (_) {}
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
