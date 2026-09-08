import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

/// Builds [GraphQLClient]s pointed at [endpoint], the `modules/server`
/// GraphQL endpoint chosen by the host app — this package has no way to
/// know which environment it should talk to.
class GraphQlClientFactory {
  const GraphQlClientFactory({required this.endpoint});

  final Uri endpoint;

  GraphQLClient create({Link? loggingLink}) {
    final httpLink = HttpLink(endpoint.toString());
    return GraphQLClient(
      link: loggingLink != null ? loggingLink.concat(httpLink) : httpLink,
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
