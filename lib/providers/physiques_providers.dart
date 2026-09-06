import 'package:api_client/api_client.dart';
import 'package:app_logging/app_logging.dart';
import 'package:data_pack/data_pack.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:graphql_client/graphql_client.dart';

import '../config/physique_server_config.dart';
import '../services/physique_antenna_category_resolver.dart';
import '../services/physique_identification_service.dart';
import '../services/physique_legend_grid_service.dart';
import 'app_initialization_providers.dart';
import 'physique_table_cache_providers.dart';

final physiquesApiClientProvider = Provider<PhysiquesApiClient>(
  (ref) => PhysiquesApiClient(
    Uri.parse(physiqueServerConfig.baseUrl),
    client: LoggingHttpClient(),
  ),
);

final physiqueAntennaCategoryResolverProvider =
    Provider<PhysiqueAntennaCategoryResolver>(
      (ref) => PhysiqueAntennaCategoryResolver(
        ref.watch(physiqueTableMetadataCacheRepositoryProvider),
      ),
    );

/// Identifies a physique from cached table rows via `denpamemo_logics`
/// — see [PhysiqueIdentificationService].
final physiqueIdentificationServiceProvider =
    Provider<PhysiqueIdentificationService>(
      (ref) => PhysiqueIdentificationService(
        tableCacheRepository: ref.watch(physiqueTableCacheRepositoryProvider),
        categoryCacheRepository: ref.watch(
          evasionRateCategoryCacheRepositoryProvider,
        ),
        antennaCategoryResolver: ref.watch(
          physiqueAntennaCategoryResolverProvider,
        ),
        awaitInitialSync: () => ref.read(appInitializationProvider.future),
      ),
    );

/// Builds the "matching location" grid from cached table rows via
/// `denpamemo_logics` — see [PhysiqueLegendGridService].
final physiqueLegendGridServiceProvider = Provider<PhysiqueLegendGridService>(
  (ref) => PhysiqueLegendGridService(
    tableCacheRepository: ref.watch(physiqueTableCacheRepositoryProvider),
    categoryCacheRepository: ref.watch(
      evasionRateCategoryCacheRepositoryProvider,
    ),
    awaitInitialSync: () => ref.read(appInitializationProvider.future),
  ),
);

/// The "matching location" grid for one identification result — see
/// [PhysiqueLegendGridService]. Read-only reference data tied to a
/// specific search result, so `autoDispose` is appropriate (no need to
/// keep it cached once the page showing it is closed).
final legendGridProvider = FutureProvider.autoDispose
    .family<LegendGridResult, LegendGridRequest>(
      (ref, request) =>
          ref.read(physiqueLegendGridServiceProvider).legendGrid(request),
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

/// The physique-category legend (`GET /tables/evasion-rate-categories`),
/// falling back to the last successfully fetched rows when the server is
/// unreachable — cached ahead of time so offline identification can
/// resolve evasion-rate ranges to categories.
final evasionRateCategoriesProvider =
    FutureProvider<List<PhysiqueEvasionRateCategoryRow>>((ref) {
      final client = ref.watch(physiquesApiClientProvider);
      final cacheRepository = ref.watch(
        evasionRateCategoryCacheRepositoryProvider,
      );
      return _fetchWithCacheFallback(
        fetch: client.fetchEvasionRateCategories,
        save: cacheRepository.replaceAll,
        cached: cacheRepository.cachedCategories,
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
