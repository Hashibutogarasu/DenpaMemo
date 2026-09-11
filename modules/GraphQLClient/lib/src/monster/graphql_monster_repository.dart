import 'package:data_pack/data_pack.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

import '../dio_graphql_link.dart';
import 'monster_graphql_queries.dart';
import '../graphql_network_extensions.dart';

/// [MonsterRepository] implementation backed by the `modules/server`
/// GraphQL API's isolated `monsters` query (separate from `masterData`).
class GraphqlMonsterRepository implements MonsterRepository {
  GraphqlMonsterRepository({required GraphQLClient client}) : _client = client;

  final GraphQLClient _client;

  /// Runs the `monsters` GraphQL query, returning its raw response list
  /// and the [DioLoggingInterceptor] request id that logged it (see
  /// [DioRequestIdContext]), without mapping the data yet — used instead
  /// of [load] by callers that need to cache the response verbatim.
  Future<({List<dynamic> data, String? requestId})> fetchRaw() async {
    final result = await _client.networkQuery(
      QueryOptions(
        document: gql(monsterListQuery),
        fetchPolicy: FetchPolicy.networkOnly,
      ),
    );

    return (
      data: result.data!['monsters'] as List<dynamic>,
      requestId: result.context.entry<DioRequestIdContext>()?.requestId,
    );
  }

  @override
  Future<List<Monster>> load() async {
    return monstersFromGraphqlJson((await fetchRaw()).data);
  }
}

/// Maps a `monsters` GraphQL response (as returned by
/// [GraphqlMonsterRepository.fetchRaw]) to [Monster]s. Shared by the live
/// network path and any code that replays a cached response through the
/// same mapping.
List<Monster> monstersFromGraphqlJson(List<dynamic> monsters) => [
  for (final json in monsters) Monster.fromJson(json as Map<String, dynamic>),
];
