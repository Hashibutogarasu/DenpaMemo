import 'package:api_client/api_client.dart';
import 'package:data_pack/data_pack.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:graphql_client/graphql_client.dart';

import '../config/physique_server_config.dart';
import 'physique_table_cache_providers.dart';

final physiquesApiClientProvider = Provider<PhysiquesApiClient>(
  (ref) => PhysiquesApiClient(Uri.parse(physiqueServerConfig.baseUrl)),
);

/// Awaits [fetch] up to [timeout]; on success, [save]s it to the local
/// cache before returning it. On timeout or any other failure, falls
/// back to [cached] instead of leaving the caller waiting forever —
/// rethrowing only if there is nothing cached to fall back to.
Future<T> _fetchWithCacheFallback<T>({
  required Future<T> Function() fetch,
  required void Function(T value) save,
  required T? Function() cached,
  Duration timeout = const Duration(seconds: 5),
}) async {
  try {
    final value = await fetch().timeout(timeout);
    save(value);
    return value;
  } catch (_) {
    final fallback = cached();
    if (fallback != null) return fallback;
    rethrow;
  }
}

/// Every registered table type (see `GET /tables/types`), so the app never
/// hardcodes which physique table types (HP, speed, ...) exist. Falls back
/// to the last successfully fetched list when the server is unreachable.
final tableTypesProvider = FutureProvider<List<TableDefinition>>((ref) {
  final client = ref.watch(physiquesApiClientProvider);
  final cacheRepository = ref.watch(
    physiqueTableMetadataCacheRepositoryProvider,
  );
  return _fetchWithCacheFallback(
    fetch: client.fetchTypes,
    save: cacheRepository.saveTableTypes,
    cached: cacheRepository.cachedTableTypes,
  );
});

/// The antenna/status category metadata behind [physiqueTableMetadataProvider],
/// falling back to the last successfully fetched value when the server is
/// unreachable rather than leaving [PhysiqueTableListPage] loading forever.
final physiqueTableMetadataWithCacheProvider =
    FutureProvider<PhysiqueTableMetadata>((ref) {
      final cacheRepository = ref.watch(
        physiqueTableMetadataCacheRepositoryProvider,
      );
      return _fetchWithCacheFallback(
        fetch: () => ref.read(physiqueTableMetadataProvider.future),
        save: cacheRepository.saveMetadata,
        cached: cacheRepository.cachedMetadata,
      );
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
