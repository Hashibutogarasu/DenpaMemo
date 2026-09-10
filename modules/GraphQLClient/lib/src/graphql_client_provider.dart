import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

import 'dio_graphql_link.dart';

/// Builds [GraphQLClient]s pointed at [endpoint], the `modules/server`
/// GraphQL endpoint chosen by the host app — this package has no way to
/// know which environment it should talk to.
class GraphQlClientFactory {
  const GraphQlClientFactory({required this.endpoint});

  final Uri endpoint;

  /// [dio] is the app's single shared [Dio] instance, so GraphQL traffic
  /// flows through — and is captured by the same debug-log interceptor
  /// as — every other network call in the app, rather than through
  /// `graphql_flutter`'s own `HttpLink`/`http.Client`.
  GraphQLClient create({required Dio dio}) {
    return GraphQLClient(
      link: DioGraphQlLink(dio, endpoint),
      cache: GraphQLCache(),
    );
  }
}

/// Placeholder that must be overridden by the host app with a
/// [GraphQlClientFactory]-built client pointed at its own chosen endpoint.
final graphQLClientProvider = Provider<GraphQLClient>((ref) {
  throw UnimplementedError(
    'graphQLClientProvider must be overridden by the host app',
  );
});
