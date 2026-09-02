import 'package:data_pack/data_pack.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

import 'physique_antenna_category_graphql_queries.dart';

/// Fetches [PhysiqueTableMetadata] via [physiqueAntennaCategoriesQuery].
/// Not cached like [GraphqlMasterDataRepository]: this data only feeds the
/// developer-only physique table screens, which fetch on demand.
class GraphqlPhysiqueAntennaCategoryRepository {
  GraphqlPhysiqueAntennaCategoryRepository({required GraphQLClient client})
    : _client = client;

  final GraphQLClient _client;

  Future<PhysiqueTableMetadata> load() async {
    final result = await _client.query(
      QueryOptions(
        document: gql(physiqueAntennaCategoriesQuery),
        fetchPolicy: FetchPolicy.networkOnly,
      ),
    );

    if (result.hasException) {
      throw result.exception!;
    }

    return PhysiqueTableMetadata.fromJson(
      result.data!['masterData'] as Map<String, dynamic>,
    );
  }
}
