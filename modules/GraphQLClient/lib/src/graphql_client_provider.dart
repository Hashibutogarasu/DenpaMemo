import 'dart:io' show Platform;

import 'package:flutter/foundation.dart' show kDebugMode;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:app_logging/app_logging.dart';

/// Builds [GraphQLClient]s pointed at the `modules/server` GraphQL
/// endpoint. Not configurable via `.env` or `--dart-define` yet — that
/// is deliberately out of scope until the app needs to point at more
/// than one environment.
class GraphQlClientFactory {
  const GraphQlClientFactory();

  static const _androidDebugEndpoint =
      'https://denpamemo-dev.karasu256.com/graphql';

  String get endpoint {
    if (Platform.isAndroid && kDebugMode) {
      return _androidDebugEndpoint;
    }
    final host = Platform.isAndroid ? '10.0.2.2' : 'localhost';
    return 'http://$host:4100/graphql';
  }

  GraphQLClient create({Link? loggingLink}) {
    final httpLink = HttpLink(endpoint);
    return GraphQLClient(
      link: loggingLink != null ? loggingLink.concat(httpLink) : httpLink,
      cache: GraphQLCache(),
    );
  }
}

const graphQlClientFactory = GraphQlClientFactory();

final graphQLClientProvider = Provider<GraphQLClient>((ref) {
  return graphQlClientFactory.create(loggingLink: LoggingGraphQLLink());
});
