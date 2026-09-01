import 'dart:io';
import 'dart:math';

import 'package:platform_utils/platform_utils.dart';
import 'package:url_launcher/url_launcher.dart';

import 'exceptions.dart';
import 'google_oauth_client_config.dart';

/// The authorization code received on the loopback server, plus the
/// dynamic `redirect_uri` that was actually used for this attempt (a new
/// ephemeral port each time) — both are needed by the later token
/// exchange/issuance steps.
class GoogleLoopbackAuthorizationResult {
  const GoogleLoopbackAuthorizationResult({required this.authorizationCode, required this.redirectUri});

  final String authorizationCode;
  final String redirectUri;
}

/// Runs the desktop OAuth loopback flow (RFC 8252): opens the system
/// browser to Google's consent screen — or, when no display server is
/// available, hands the URL to [onManualAuthUrl] for the caller to present
/// — then waits for the authorization redirect on a local HTTP server.
class GoogleLoopbackAuthorizer {
  static const _googleAuthScope = 'openid email profile';

  Future<GoogleLoopbackAuthorizationResult> authorize({
    required GoogleOAuthClientConfig config,
    void Function(Uri? authUrl)? onManualAuthUrl,
  }) async {
    final state = _randomState();
    final server = await HttpServer.bind(InternetAddress.loopbackIPv4, 0);
    try {
      final redirectUri = 'http://localhost:${server.port}';
      final authUrl = Uri.parse(config.authUri).replace(
        queryParameters: {
          'client_id': config.clientId,
          'redirect_uri': redirectUri,
          'response_type': 'code',
          'scope': _googleAuthScope,
          'state': state,
        },
      );
      if (isLinuxWithoutDisplay()) {
        onManualAuthUrl?.call(authUrl);
      } else {
        bool launched;
        try {
          launched = await launchUrl(authUrl, mode: LaunchMode.externalApplication);
        } catch (_) {
          launched = false;
        }
        if (!launched) {
          onManualAuthUrl?.call(authUrl);
        }
      }
      final code = await _awaitLoopbackRedirect(server, state);
      onManualAuthUrl?.call(null);
      return GoogleLoopbackAuthorizationResult(authorizationCode: code, redirectUri: redirectUri);
    } finally {
      await server.close(force: true);
    }
  }

  /// Ignores any request carrying none of `error`/`code`/`state` (e.g. a
  /// stray `favicon.ico` fetch the browser makes against the loopback
  /// origin) and keeps waiting for the actual OAuth redirect.
  Future<String> _awaitLoopbackRedirect(HttpServer server, String expectedState) async {
    await for (final request in server) {
      final params = request.uri.queryParameters;
      final error = params['error'];
      final code = params['code'];
      final state = params['state'];

      if (error == null && code == null && state == null) {
        request.response.statusCode = HttpStatus.notFound;
        await request.response.close();
        continue;
      }

      request.response.headers.contentType = ContentType.html;
      if (error != null) {
        request.response.write('<html><body>Sign-in was cancelled. You may close this tab.</body></html>');
        await request.response.close();
        throw GoogleSignInLoopbackException('Google denied the request: $error');
      }
      if (state != expectedState) {
        request.response.write('<html><body>Sign-in failed. You may close this tab.</body></html>');
        await request.response.close();
        throw const GoogleSignInLoopbackException('OAuth state mismatch.');
      }
      if (code == null) {
        request.response.write('<html><body>Sign-in failed. You may close this tab.</body></html>');
        await request.response.close();
        throw const GoogleSignInLoopbackException('No authorization code received.');
      }
      request.response.write('<html><body>Signed in. You may close this tab.</body></html>');
      await request.response.close();
      return code;
    }
    throw const GoogleSignInLoopbackException('Loopback server closed unexpectedly.');
  }

  String _randomState() {
    final random = Random.secure();
    return List<int>.generate(16, (_) => random.nextInt(256))
        .map((byte) => byte.toRadixString(16).padLeft(2, '0'))
        .join();
  }
}
