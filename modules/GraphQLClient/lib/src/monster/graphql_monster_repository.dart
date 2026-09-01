import 'package:data_pack/data_pack.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

import 'monster_graphql_queries.dart';

/// [MonsterRepository] implementation backed by the `modules/server`
/// GraphQL API's isolated `monsters` query (separate from `masterData`).
class GraphqlMonsterRepository implements MonsterRepository {
  GraphqlMonsterRepository({required GraphQLClient client}) : _client = client;

  final GraphQLClient _client;

  /// Runs the `monsters` GraphQL query and returns its raw response list,
  /// without mapping it to [Monster]s yet. Callers that need to cache the
  /// server's response verbatim (see `CachingMonsterRepository`) use this
  /// instead of [load].
  Future<List<dynamic>> fetchRaw() async {
    final result = await _client.query(
      QueryOptions(
        document: gql(monsterListQuery),
        fetchPolicy: FetchPolicy.networkOnly,
      ),
    );

    if (result.hasException) {
      throw result.exception!;
    }

    return result.data!['monsters'] as List<dynamic>;
  }

  @override
  Future<List<Monster>> load() async {
    return monstersFromGraphqlJson(await fetchRaw());
  }
}

/// Maps a `monsters` GraphQL response (as returned by
/// [GraphqlMonsterRepository.fetchRaw]) to [Monster]s. Shared by the live
/// network path and any code that replays a cached response through the
/// same mapping.
List<Monster> monstersFromGraphqlJson(List<dynamic> monsters) => [
  for (final json in monsters) Monster.fromJson(json as Map<String, dynamic>),
];
