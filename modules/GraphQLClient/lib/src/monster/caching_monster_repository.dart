import 'package:data_cache/data_cache.dart';
import 'package:data_pack/data_pack.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

import 'graphql_monster_repository.dart';

const monsterListCacheKey = 'monsters';

/// [MonsterRepository] that fetches through [GraphqlMonsterRepository] when
/// the server is reachable, keeping [cache] in sync via
/// [CacheIndexRepository.save], and falls back to the cached response when
/// the connection itself fails. A server-returned GraphQL error is not
/// treated as a connectivity failure and is never masked by the cache.
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
      final raw = await _inner.fetchRaw();
      await _cache.save(monsterListCacheKey, const <String, dynamic>{}, {
        'monsters': raw,
      });
      return monstersFromGraphqlJson(raw);
    } on OperationException catch (exception) {
      if (exception.linkException == null) {
        rethrow;
      }
      final cached = await _cache
          .read<Map<String, dynamic>, List<Monster>>(
            monsterListCacheKey,
            inputFromJson: (json) => json,
            outputFromJson: (json) =>
                monstersFromGraphqlJson(json['monsters'] as List<dynamic>),
          );
      if (cached == null) {
        rethrow;
      }
      return cached.output;
    }
  }
}
