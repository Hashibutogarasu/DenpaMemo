import 'package:api_client/api_client.dart';
import 'package:data_pack/data_pack.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:graphql_client/graphql_client.dart';

import 'denpa_men_sync_providers.dart';
import 'physique_table_cache_providers.dart';
import 'physique_table_sync_providers.dart';
import 'physiques_providers.dart';

/// Runs every startup data task that must finish before the app is usable
/// offline: fetching [masterDataProvider] and syncing stored records
/// against it via [DenpaMenSyncService], and warming every cache physique
/// identification and the physique table editor need — table rows,
/// antenna-category metadata, and the evasion-rate category legend — so
/// none of it depends on which screen happens to be opened first. The
/// single provider the app root watches once at launch, kept independent
/// of the splash screen so the splash never needs to know what is
/// loading. The four tasks below are mutually independent, so they run
/// concurrently rather than one after another — otherwise a slow or
/// unreachable server would stack up each task's own timeout instead of
/// paying it once.
final appInitializationProvider = FutureProvider<void>((ref) async {
  await Future.wait([
    _syncDenpaMen(ref),
    _prefetchPhysiqueTables(ref),
    _warmPhysiqueTableMetadata(ref),
    _warmEvasionRateCategories(ref),
  ]);
}, retry: (_, _) => null);

Future<void> _syncDenpaMen(Ref ref) async {
  try {
    final masterData = await ref.watch(masterDataProvider.future);
    final denpaMenSync = ref.watch(denpaMenSyncServiceProvider);
    await denpaMenSync.sync(masterData);
  } catch (_) {}
}

Future<void> _prefetchPhysiqueTables(Ref ref) async {
  try {
    final tableSync = ref.watch(physiqueTableSyncServiceProvider);
    final types = await ref.watch(tableTypesProvider.future);
    await tableSync.prefetch(types);
  } catch (_) {}
}

Future<void> _warmPhysiqueTableMetadata(Ref ref) async {
  try {
    await ref.watch(physiqueTableMetadataWithCacheProvider.future);
  } catch (_) {}
}

Future<void> _warmEvasionRateCategories(Ref ref) async {
  try {
    await ref.watch(evasionRateCategoriesProvider.future);
  } catch (_) {}
}

/// Every registered table type, read straight from the local cache
/// [appInitializationProvider] already populated — screens read this
/// instead of watching [tableTypesProvider] themselves, so opening one
/// never triggers its own fetch.
final cachedTableTypesProvider = Provider<List<TableDefinition>?>((ref) {
  ref.watch(appInitializationProvider);
  return ref
      .watch(physiqueTableMetadataCacheRepositoryProvider)
      .cachedTableTypes();
});

/// The antenna/status category metadata, read straight from the local
/// cache [appInitializationProvider] already populated — see
/// [cachedTableTypesProvider].
final cachedPhysiqueTableMetadataProvider = Provider<PhysiqueTableMetadata?>((
  ref,
) {
  ref.watch(appInitializationProvider);
  return ref
      .watch(physiqueTableMetadataCacheRepositoryProvider)
      .cachedMetadata();
});
