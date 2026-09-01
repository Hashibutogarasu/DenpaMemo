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

  static const _productionEndpoint = 'https://api.denpa_memo.karasu256.com';

  String get baseUrl {
    if (!kDebugMode) {
      return _productionEndpoint;
    }
    final host = Platform.isAndroid ? '10.0.2.2' : 'localhost';
    return 'http://$host:8787';
  }
}

const authApiConfig = AuthApiConfig();
