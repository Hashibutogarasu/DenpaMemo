import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

/// The `modules/server` GraphQL endpoint. Not configurable via `.env` or
/// `--dart-define` yet — that is deliberately out of scope until the app
/// needs to point at more than one environment.
const graphQlEndpoint = 'http://localhost:4100/graphql';

/// Builds a fresh [GraphQLClient] pointed at [graphQlEndpoint]. Shared by
/// [graphQLClientProvider] and `main()`'s pre-`ProviderScope` startup code
/// (the hash migration in `migrateDenpaMenHashes` needs master data before
/// any provider exists to read it from).
GraphQLClient createGraphQlClient() {
  return GraphQLClient(link: HttpLink(graphQlEndpoint), cache: GraphQLCache());
}

final graphQLClientProvider = Provider<GraphQLClient>((ref) {
  return createGraphQlClient();
});
