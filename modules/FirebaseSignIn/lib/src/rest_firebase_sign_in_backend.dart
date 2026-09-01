import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';

import 'cloud_account_state.dart';
import 'exceptions.dart';
import 'firebase_sign_in_backend.dart';
import 'google_oauth_client_config.dart';

const _identityToolkitBase = 'https://identitytoolkit.googleapis.com/v1';
const _secureTokenBase = 'https://securetoken.googleapis.com/v1';
const _googleAuthScope = 'openid email profile';
const _sessionStorageKey = 'firebase_sign_in.session';

class _Session {
  _Session({
    required this.idToken,
    required this.refreshToken,
    required this.localId,
    required this.email,
    required this.expiresAt,
  });

  factory _Session.fromJson(Map<String, dynamic> json) => _Session(
    idToken: json['idToken'] as String,
    refreshToken: json['refreshToken'] as String,
    localId: json['localId'] as String,
    email: json['email'] as String?,
    expiresAt: DateTime.fromMillisecondsSinceEpoch(json['expiresAtEpochMs'] as int),
  );

  factory _Session.fromIdentityToolkitResponse(Map<String, dynamic> body) => _Session(
    idToken: body['idToken'] as String,
    refreshToken: body['refreshToken'] as String,
    localId: body['localId'] as String,
    email: body['email'] as String?,
    expiresAt: DateTime.now().add(Duration(seconds: int.parse(body['expiresIn'] as String))),
  );

  final String idToken;
  final String refreshToken;
  final String localId;
  final String? email;
  final DateTime expiresAt;

  bool get isExpired => DateTime.now().isAfter(expiresAt);

  Map<String, dynamic> toJson() => {
    'idToken': idToken,
    'refreshToken': refreshToken,
    'localId': localId,
    'email': email,
    'expiresAtEpochMs': expiresAt.millisecondsSinceEpoch,
  };

  CloudAccountState toState() => CloudAccountState(isSignedIn: true, email: email, uid: localId);
}

/// Backend implementation for platforms without a registered native
/// Firebase app (e.g. Linux desktop, where `firebase_core` has no native
/// plugin) — drives the Firebase Identity Toolkit REST API directly, and
/// implements Google sign-in via a desktop OAuth loopback flow (RFC 8252):
/// the system browser is opened to Google's consent screen, and a
/// short-lived local HTTP server receives the redirect.
class RestFirebaseSignInBackend implements FirebaseSignInBackend {
  RestFirebaseSignInBackend({
    required this.apiKey,
    required this.googleOAuthClientConfig,
    FlutterSecureStorage? storage,
    http.Client? httpClient,
  }) : _storage = storage ?? const FlutterSecureStorage(),
       _httpClient = httpClient ?? http.Client();

  final String apiKey;
  final GoogleOAuthClientConfig googleOAuthClientConfig;
  final FlutterSecureStorage _storage;
  final http.Client _httpClient;

  _Session? _session;

  @override
  CloudAccountState currentState() => _session?.toState() ?? const CloudAccountState();

  @override
  Future<void> ready() async {
    final stored = await _storage.read(key: _sessionStorageKey);
    if (stored == null) {
      return;
    }
    _session = _Session.fromJson(jsonDecode(stored) as Map<String, dynamic>);
  }

  @override
  Future<CloudAccountState> signInWithEmail(String email, String password) => _persistAndReturn(
    _identityToolkitRequest('accounts:signInWithPassword', {
      'email': email,
      'password': password,
      'returnSecureToken': true,
    }),
  );

  @override
  Future<CloudAccountState> signUpWithEmail(String email, String password) => _persistAndReturn(
    _identityToolkitRequest('accounts:signUp', {
      'email': email,
      'password': password,
      'returnSecureToken': true,
    }),
  );

  @override
  Future<CloudAccountState> signInWithGoogle() async {
    final googleIdToken = await _runGoogleLoopback();
    return _persistAndReturn(
      _identityToolkitRequest('accounts:signInWithIdp', {
        'postBody': 'id_token=$googleIdToken&providerId=google.com',
        'requestUri': googleOAuthClientConfig.redirectUri,
        'returnSecureToken': true,
      }),
    );
  }

  @override
  Future<void> signOut() async {
    await _storage.delete(key: _sessionStorageKey);
    _session = null;
  }

  @override
  Future<String?> getIdToken() async {
    final session = _session;
    if (session == null) {
      return null;
    }
    if (!session.isExpired) {
      return session.idToken;
    }
    try {
      final response = await _httpClient.post(
        Uri.parse('$_secureTokenBase/token?key=$apiKey'),
        headers: {'Content-Type': 'application/x-www-form-urlencoded'},
        body: {'grant_type': 'refresh_token', 'refresh_token': session.refreshToken},
      );
      final body = _decodeOrThrow(response);
      final refreshed = _Session(
        idToken: body['id_token'] as String,
        refreshToken: body['refresh_token'] as String,
        localId: body['user_id'] as String,
        email: session.email,
        expiresAt: DateTime.now().add(Duration(seconds: int.parse(body['expires_in'] as String))),
      );
      await _persist(refreshed);
      return refreshed.idToken;
    } catch (_) {
      await signOut();
      rethrow;
    }
  }

  @override
  Future<void> deleteAccount() async {
    final session = _session;
    if (session == null) {
      throw const NotSignedInException();
    }
    await _identityToolkitRequest('accounts:delete', {'idToken': session.idToken});
    await signOut();
  }

  Future<Map<String, dynamic>> _identityToolkitRequest(
    String method,
    Map<String, dynamic> body,
  ) async {
    final response = await _httpClient.post(
      Uri.parse('$_identityToolkitBase/$method?key=$apiKey'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(body),
    );
    return _decodeOrThrow(response);
  }

  Future<CloudAccountState> _persistAndReturn(Future<Map<String, dynamic>> request) async {
    final body = await request;
    final session = _Session.fromIdentityToolkitResponse(body);
    await _persist(session);
    return session.toState();
  }

  Future<void> _persist(_Session session) async {
    _session = session;
    await _storage.write(key: _sessionStorageKey, value: jsonEncode(session.toJson()));
  }

  Map<String, dynamic> _decodeOrThrow(http.Response response) {
    final decoded = jsonDecode(response.body) as Map<String, dynamic>;
    if (response.statusCode >= 200 && response.statusCode < 300) {
      return decoded;
    }
    final error = decoded['error'] as Map<String, dynamic>?;
    final errors = error?['errors'] as List<dynamic>?;
    final errorCode = (errors?.isNotEmpty ?? false)
        ? (errors!.first as Map<String, dynamic>)['message'] as String?
        : null;
    throw RestAuthException(
      statusCode: response.statusCode,
      errorCode: errorCode ?? error?['message'] as String? ?? 'UNKNOWN_ERROR',
      rawMessage: error?['message'] as String?,
    );
  }

  Future<String> _runGoogleLoopback() async {
    final state = _randomState();
    final server = await HttpServer.bind(InternetAddress.loopbackIPv4, 0);
    try {
      final redirectUri = 'http://localhost:${server.port}';
      final authUrl = Uri.parse(googleOAuthClientConfig.authUri).replace(
        queryParameters: {
          'client_id': googleOAuthClientConfig.clientId,
          'redirect_uri': redirectUri,
          'response_type': 'code',
          'scope': _googleAuthScope,
          'state': state,
        },
      );
      final launched = await launchUrl(authUrl, mode: LaunchMode.externalApplication);
      if (!launched) {
        throw const GoogleSignInLoopbackException('Could not open the system browser.');
      }
      final code = await _awaitLoopbackRedirect(server, state);
      final tokenResponse = await _httpClient.post(
        Uri.parse(googleOAuthClientConfig.tokenUri),
        headers: {'Content-Type': 'application/x-www-form-urlencoded'},
        body: {
          'client_id': googleOAuthClientConfig.clientId,
          'client_secret': googleOAuthClientConfig.clientSecret,
          'code': code,
          'grant_type': 'authorization_code',
          'redirect_uri': redirectUri,
        },
      );
      final tokenBody = _decodeOrThrow(tokenResponse);
      return tokenBody['id_token'] as String;
    } finally {
      await server.close(force: true);
    }
  }

  Future<String> _awaitLoopbackRedirect(HttpServer server, String expectedState) async {
    await for (final request in server) {
      final params = request.uri.queryParameters;
      request.response.headers.contentType = ContentType.html;
      final error = params['error'];
      final code = params['code'];
      final state = params['state'];
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
