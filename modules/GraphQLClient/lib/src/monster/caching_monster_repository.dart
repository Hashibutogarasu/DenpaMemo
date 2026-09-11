import 'package:app_logging/app_logging.dart';
import 'package:data_cache/data_cache.dart';
import 'package:data_pack/data_pack.dart';

import 'graphql_monster_repository.dart';

const monsterListCacheKey = 'monsters';

/// [MonsterRepository] that fetches through [GraphqlMonsterRepository] when
/// reachable, keeping [cache] in sync via [CacheIndexRepository.save], and
/// falls back to the cached response when the connection itself fails (a
/// server-returned GraphQL error is never masked by the cache).
class CachingMonsterRepository implements MonsterRepository {
  CachingMonsterRepository({
    required GraphqlMonsterRepository inner,
    required CacheIndexRepository cache,
  }) : _inner = inner,
       _cache = cache;

  final GraphqlMonsterRepository _inner;
  final CacheIndexRepository _cache;

  @override
  Future<List<Monster>> load() async {
    try {
      final result = await _inner.fetchRaw();
      final syncResult = await _cache.save(
        monsterListCacheKey,
        const <String, dynamic>{},
        {'monsters': result.data},
      );
      if (syncResult == CacheSyncResult.unchanged && result.requestId != null) {
        LogBus.instance.updateNetworkStatus(
          result.requestId!,
          NetworkLogStatus.unchanged,
        );
      }
      return monstersFromGraphqlJson(result.data);
    } on OfflineNetworkException catch (exception) {
      return _readCachedOrThrow(exception);
    } on NetworkTimeoutException catch (exception) {
      return _readCachedOrThrow(exception);
    } on NetworkConnectionException catch (exception) {
      return _readCachedOrThrow(exception);
    }
  }

  Future<List<Monster>> _readCachedOrThrow(NetworkFailure failure) async {
    final cached = await _cache.read<Map<String, dynamic>, List<Monster>>(
      monsterListCacheKey,
      inputFromJson: (json) => json,
      outputFromJson: (json) =>
          monstersFromGraphqlJson(json['monsters'] as List<dynamic>),
    );
    if (cached == null) {
      throw failure;
    }
    return cached.output;
  }
}
