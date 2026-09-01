import 'dart:io' show Platform;

import 'package:flutter/foundation.dart' show kDebugMode;

/// Builds the base URL of the `modules/auth` Cloudflare Worker, following
/// the same debug/platform-aware pattern as `GraphQlClientFactory`
/// (`modules/GraphQLClient/lib/src/graphql_client_provider.dart`). Not
/// configurable via `.env` or `--dart-define` yet, matching that same
/// deliberate scope decision — the production endpoint is also still a
/// placeholder until that Worker is actually deployed.
class AuthApiConfig {
  const AuthApiConfig();

  static const _productionEndpoint = 'https://denpamemo-auth.karasu256.com';
  static const _androidDebugEndpoint = 'https://denpamemo-auth-dev.karasu256.com';

  String get baseUrl {
    if (!kDebugMode) {
      return _productionEndpoint;
    }
    if (Platform.isAndroid) {
      return _androidDebugEndpoint;
    }
    return 'http://localhost:8787';
  }
}

const authApiConfig = AuthApiConfig();
