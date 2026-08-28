import 'package:data_pack/data_pack.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/master_data/graphql_master_data_repository.dart';
import 'graphql_client_provider.dart';

final masterDataRepositoryProvider = Provider<MasterDataRepository>((ref) {
  final client = ref.watch(graphQLClientProvider);
  return GraphqlMasterDataRepository(client: client);
});

/// `retry: (_, _) => null` disables Riverpod's default automatic retry
/// (exponential backoff, up to 10 attempts) for this provider: without
/// it, a server outage would make Riverpod silently re-run [load] itself
/// several times over ~30 seconds, each failure independently reaching
/// `listenForMasterDataErrors` and stacking up a fresh `ErrorDialog` for
/// every one of those unrequested attempts. Re-fetching should only ever
/// happen from an explicit user action (the dialog's retry button).
final masterDataProvider = FutureProvider<MasterData>((ref) {
  final repository = ref.watch(masterDataRepositoryProvider);
  return repository.load();
}, retry: (_, _) => null);
