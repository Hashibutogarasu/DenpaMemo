import 'package:data_cache/data_cache.dart';
import 'package:data_pack/data_pack.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

import 'graphql_master_data_repository.dart';

const masterDataCacheKey = 'master_data';

/// [MasterDataRepository] that fetches through [GraphqlMasterDataRepository]
/// when the server is reachable, keeping [cache] in sync via
/// [CacheIndexRepository.save], and falls back to the cached response when
/// the connection itself fails. A server-returned GraphQL error is not
/// treated as a connectivity failure and is never masked by the cache.
class CachingMasterDataRepository implements MasterDataRepository {
  CachingMasterDataRepository({
    required GraphqlMasterDataRepository inner,
    required CacheIndexRepository cache,
  }) : _inner = inner,
       _cache = cache;

  final GraphqlMasterDataRepository _inner;
  final CacheIndexRepository _cache;

  @override
  Future<MasterData> load() async {
    try {
      final raw = await _inner.fetchRaw();
      await _cache.save(masterDataCacheKey, const <String, dynamic>{}, raw);
      return masterDataFromGraphqlJson(raw);
    } on OperationException catch (exception) {
      if (exception.linkException == null) {
        rethrow;
      }
      final cached = await _cache
          .read<Map<String, dynamic>, MasterData>(
            masterDataCacheKey,
            inputFromJson: (json) => json,
            outputFromJson: masterDataFromGraphqlJson,
          );
      if (cached == null) {
        rethrow;
      }
      return cached.output;
    }
  }
}
