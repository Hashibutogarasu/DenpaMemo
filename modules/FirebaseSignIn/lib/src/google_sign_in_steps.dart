import 'package:step_dialog/step_dialog.dart';

import 'google_oauth_client_config.dart';
import 'google_oauth_loopback.dart';
import 'identity_toolkit_client.dart';

/// Shared, mutable working state for the 5-step Google sign-in flow —
/// accumulates results as each [Step] runs, and carries the dependencies
/// each step needs.
class GoogleSignInStepContext {
  GoogleSignInStepContext({
    required this.googleOAuthClientConfig,
    required this.identityToolkitClient,
    required this.googleOAuthTokenClient,
    required this.loopbackAuthorizer,
    required this.persist,
    this.onManualAuthUrl,
  });

  final GoogleOAuthClientConfig googleOAuthClientConfig;
  final IdentityToolkitClient identityToolkitClient;
  final GoogleOAuthTokenClient googleOAuthTokenClient;
  final GoogleLoopbackAuthorizer loopbackAuthorizer;
  final Future<void> Function(IdentityToolkitSession session) persist;
  final void Function(Uri? authUrl)? onManualAuthUrl;

  GoogleLoopbackAuthorizationResult? authorization;
  String? googleIdToken;
  IdentityToolkitSession? firebaseSession;
  IdentityToolkitSession? refreshedSession;
  String? uid;
}

/// Receives the authenticated authorization code from the local loopback
/// web server (opening the system browser, or falling back to
/// [GoogleSignInStepContext.onManualAuthUrl] when none is available).
class ReceiveLoopbackAuthorizationStep extends Step<GoogleSignInStepContext> {
  @override
  Future<void> run(GoogleSignInStepContext context) async {
    context.authorization = await context.loopbackAuthorizer.authorize(
      config: context.googleOAuthClientConfig,
      onManualAuthUrl: context.onManualAuthUrl,
    );
    reportProgress();
  }
}

/// Exchanges the authorization code for a Google ID token.
class ExchangeAuthorizationCodeStep extends Step<GoogleSignInStepContext> {
  @override
  Future<void> run(GoogleSignInStepContext context) async {
    final authorization = context.authorization!;
    context.googleIdToken = await context.googleOAuthTokenClient.exchangeAuthorizationCode(
      config: context.googleOAuthClientConfig,
      code: authorization.authorizationCode,
      redirectUri: authorization.redirectUri,
    );
    reportProgress();
  }
}

/// Uses the Google ID token to issue a Firebase session (ID token +
/// refresh token) — the token-issuance unit encapsulated in
/// [IdentityToolkitClient.signInWithIdp].
class IssueFirebaseSessionStep extends Step<GoogleSignInStepContext> {
  @override
  Future<void> run(GoogleSignInStepContext context) async {
    context.firebaseSession = await context.identityToolkitClient.signInWithIdp(
      googleIdToken: context.googleIdToken!,
      requestUri: context.authorization!.redirectUri,
    );
    reportProgress();
  }
}

/// Immediately exercises the refresh-token exchange once as part of
/// sign-in, rather than lazily on the next expired [getIdToken] call — the
/// token-refresh unit encapsulated in [IdentityToolkitClient.refresh].
class RefreshFirebaseSessionStep extends Step<GoogleSignInStepContext> {
  @override
  Future<void> run(GoogleSignInStepContext context) async {
    final session = context.firebaseSession!;
    context.refreshedSession = await context.identityToolkitClient.refresh(
      refreshToken: session.refreshToken,
      email: session.email,
    );
    reportProgress();
  }
}

/// Extracts the uid from the refreshed session and persists it.
class ExtractAndPersistUidStep extends Step<GoogleSignInStepContext> {
  @override
  Future<void> run(GoogleSignInStepContext context) async {
    final session = context.refreshedSession!;
    context.uid = session.localId;
    await context.persist(session);
    reportProgress();
  }
}

/// The 5 steps in order, ready to be run via `runAll`.
List<Step<GoogleSignInStepContext>> buildGoogleSignInSteps() => [
  ReceiveLoopbackAuthorizationStep(),
  ExchangeAuthorizationCodeStep(),
  IssueFirebaseSessionStep(),
  RefreshFirebaseSessionStep(),
  ExtractAndPersistUidStep(),
];
