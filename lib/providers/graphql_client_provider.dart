import 'dart:io' show Platform;

import 'package:flutter/foundation.dart' show kDebugMode;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

/// Builds [GraphQLClient]s pointed at the `modules/server` GraphQL
/// endpoint. Not configurable via `.env` or `--dart-define` yet — that
/// is deliberately out of scope until the app needs to point at more
/// than one environment.
class GraphQlClientFactory {
  const GraphQlClientFactory();

  /// A debug build running on Android talks to the hosted dev server
  /// directly, since the emulator's loopback alias (`10.0.2.2`) does not
  /// reach a physical device.
  static const _androidDebugEndpoint =
      'https://denpamemo.karasu256.com/graphql';

  /// The Android emulator's `localhost` refers to the emulator itself,
  /// not the host machine the dev server runs on — `10.0.2.2` is the
  /// emulator's documented alias for that host. Every other platform
  /// this app ships for (a physical Linux desktop, sharing the same
  /// machine as the server) reaches it directly via `localhost`.
  String get endpoint {
    if (Platform.isAndroid && kDebugMode) {
      return _androidDebugEndpoint;
    }
    final host = Platform.isAndroid ? '10.0.2.2' : 'localhost';
    return 'http://$host:4100/graphql';
  }

  GraphQLClient create() {
    return GraphQLClient(link: HttpLink(endpoint), cache: GraphQLCache());
  }
}

const graphQlClientFactory = GraphQlClientFactory();

final graphQLClientProvider = Provider<GraphQLClient>((ref) {
  return graphQlClientFactory.create();
});
