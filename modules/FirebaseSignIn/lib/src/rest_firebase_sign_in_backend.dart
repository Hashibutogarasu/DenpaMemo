import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:step_dialog/step_dialog.dart';

import 'cloud_account_state.dart';
import 'exceptions.dart';
import 'firebase_sign_in_backend.dart';
import 'google_oauth_client_config.dart';
import 'google_oauth_loopback.dart';
import 'google_sign_in_steps.dart';
import 'identity_toolkit_client.dart';

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
    IdentityToolkitClient? identityToolkitClient,
    GoogleOAuthTokenClient? googleOAuthTokenClient,
    GoogleLoopbackAuthorizer? loopbackAuthorizer,
  }) : _storage = storage ?? const FlutterSecureStorage(),
       _identityToolkitClient = identityToolkitClient ?? IdentityToolkitClient(apiKey: apiKey),
       _googleOAuthTokenClient = googleOAuthTokenClient ?? GoogleOAuthTokenClient(),
       _loopbackAuthorizer = loopbackAuthorizer ?? GoogleLoopbackAuthorizer();

  static const _sessionStorageKey = 'firebase_sign_in.session';

  final String apiKey;
  final GoogleOAuthClientConfig googleOAuthClientConfig;
  final FlutterSecureStorage _storage;
  final IdentityToolkitClient _identityToolkitClient;
  final GoogleOAuthTokenClient _googleOAuthTokenClient;
  final GoogleLoopbackAuthorizer _loopbackAuthorizer;

  IdentityToolkitSession? _session;

  @override
  CloudAccountState currentState() => _session?.toState() ?? const CloudAccountState();

  @override
  Future<void> ready() async {
    final stored = await _storage.read(key: _sessionStorageKey);
    if (stored == null) {
      return;
    }
    _session = IdentityToolkitSession.fromJson(jsonDecode(stored) as Map<String, dynamic>);
  }

  @override
  Future<CloudAccountState> signInWithEmail(String email, String password) async {
    final session = await _identityToolkitClient.signInWithPassword(email, password);
    await _persist(session);
    return session.toState();
  }

  @override
  Future<CloudAccountState> signUpWithEmail(String email, String password) async {
    final session = await _identityToolkitClient.signUp(email, password);
    await _persist(session);
    return session.toState();
  }

  @override
  Future<CloudAccountState> signInWithGoogle({void Function(Uri? authUrl)? onManualAuthUrl}) async {
    final context = createGoogleSignInStepContext(onManualAuthUrl: onManualAuthUrl);
    await buildGoogleSignInSteps().runAll(context);
    return context.refreshedSession!.toState();
  }

  /// Builds a fresh [GoogleSignInStepContext] for driving the 5-step
  /// Google sign-in flow directly (e.g. from [SignInFlowDialog]), wired to
  /// this backend's dependencies and persistence.
  GoogleSignInStepContext createGoogleSignInStepContext({void Function(Uri? authUrl)? onManualAuthUrl}) =>
      GoogleSignInStepContext(
        googleOAuthClientConfig: googleOAuthClientConfig,
        identityToolkitClient: _identityToolkitClient,
        googleOAuthTokenClient: _googleOAuthTokenClient,
        loopbackAuthorizer: _loopbackAuthorizer,
        persist: _persist,
        onManualAuthUrl: onManualAuthUrl,
      );

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
      final refreshed = await _identityToolkitClient.refresh(
        refreshToken: session.refreshToken,
        email: session.email,
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
    await _identityToolkitClient.deleteAccount(session.idToken);
    await signOut();
  }

  Future<void> _persist(IdentityToolkitSession session) async {
    _session = session;
    await _storage.write(key: _sessionStorageKey, value: jsonEncode(session.toJson()));
  }
}
