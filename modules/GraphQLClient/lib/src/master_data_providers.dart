import 'package:data_cache/data_cache.dart';
import 'package:data_pack/data_pack.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'graphql_client_provider.dart';
import 'master_data/caching_master_data_repository.dart';
import 'master_data/graphql_master_data_repository.dart';

final masterDataRepositoryProvider = Provider<MasterDataRepository>((ref) {
  final client = ref.watch(graphQLClientProvider);
  final cache = ref.watch(dataCacheProvider);
  return CachingMasterDataRepository(
    inner: GraphqlMasterDataRepository(client: client),
    cache: cache,
  );
});

/// `retry: (_, _) => null` disables Riverpod's default automatic retry
/// (exponential backoff, up to 10 attempts) for this provider: without
/// it, a server outage would make Riverpod silently re-run [load] itself
/// several times over ~30 seconds, each failure independently reaching
/// `listenForMasterDataErrors` and stacking up a fresh `ErrorDialog` for
/// every one of those unrequested attempts. Re-fetching should only ever
/// happen from an explicit user action or a [cacheGenerationProvider] bump.
final masterDataProvider = FutureProvider<MasterData>((ref) {
  ref.watch(cacheGenerationProvider);
  final repository = ref.watch(masterDataRepositoryProvider);
  return repository.load();
}, retry: (_, _) => null);
