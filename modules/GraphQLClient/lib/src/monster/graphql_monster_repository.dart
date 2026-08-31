import 'package:data_pack/data_pack.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

import 'monster_graphql_queries.dart';

/// [MonsterRepository] implementation backed by the `modules/server`
/// GraphQL API's isolated `monsters` query (separate from `masterData`).
class GraphqlMonsterRepository implements MonsterRepository {
  GraphqlMonsterRepository({required GraphQLClient client}) : _client = client;

  final GraphQLClient _client;

  @override
  Future<List<Monster>> load() async {
    final result = await _client.query(
      QueryOptions(
        document: gql(monsterListQuery),
        fetchPolicy: FetchPolicy.networkOnly,
      ),
    );

    if (result.hasException) {
      throw result.exception!;
    }

    final monsters = result.data!['monsters'] as List<dynamic>;
    return [
      for (final json in monsters)
        Monster.fromJson(json as Map<String, dynamic>),
    ];
  }
}
