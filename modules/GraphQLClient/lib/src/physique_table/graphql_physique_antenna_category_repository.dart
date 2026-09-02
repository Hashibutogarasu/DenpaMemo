import 'package:graphql_flutter/graphql_flutter.dart';

import 'physique_antenna_category.dart';
import 'physique_antenna_category_graphql_queries.dart';

/// Fetches [PhysiqueAntennaCategory] rows via [physiqueAntennaCategoriesQuery].
/// Not cached like [GraphqlMasterDataRepository]: this data only feeds the
/// developer-only physique table screens, which fetch on demand.
class GraphqlPhysiqueAntennaCategoryRepository {
  GraphqlPhysiqueAntennaCategoryRepository({required GraphQLClient client})
    : _client = client;

  final GraphQLClient _client;

  Future<List<PhysiqueAntennaCategory>> load() async {
    final result = await _client.query(
      QueryOptions(
        document: gql(physiqueAntennaCategoriesQuery),
        fetchPolicy: FetchPolicy.networkOnly,
      ),
    );

    if (result.hasException) {
      throw result.exception!;
    }

    final masterData = result.data!['masterData'] as Map<String, dynamic>;
    final rows = masterData['physiqueAntennaCategories'] as List<dynamic>;
    return [
      for (final json in rows.cast<Map<String, dynamic>>())
        PhysiqueAntennaCategory(
          category: json['category'] as String,
          anntenaCategory: json['anntenaCategory'] as String,
        ),
    ];
  }
}
