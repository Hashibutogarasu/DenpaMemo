import 'dart:io' show Platform;

/// Builds the base URL of `modules/server`'s Elysia REST app, following
/// the same host-selection logic as `GraphQlClientFactory`
/// (`modules/GraphQLClient/lib/src/graphql_client_provider.dart`) minus
/// the `/graphql` path. Only reachable from the debug-only developer
/// section of Settings, so unlike [AuthApiConfig] there is no production
/// endpoint to fall back to.
class PhysiqueServerConfig {
  const PhysiqueServerConfig();

  String get baseUrl {
    final host = Platform.isAndroid ? '10.0.2.2' : 'localhost';
    return 'http://$host:4100';
  }
}

const physiqueServerConfig = PhysiqueServerConfig();
