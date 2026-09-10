import 'package:dio/dio.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'cloud_account_state.dart';
import 'firebase_options.dart';
import 'firebase_sign_in_backend.dart';
import 'google_oauth_client_config.dart';
import 'native_firebase_sign_in_backend.dart';
import 'rest_firebase_sign_in_backend.dart';

/// Must be overridden by the host app with the Google OAuth "Desktop app"
/// client config parsed from its own `assets/config/auth/google/` JSON —
/// required by [RestFirebaseSignInBackend]'s Google sign-in loopback flow.
final googleOAuthClientConfigProvider = Provider<GoogleOAuthClientConfig>(
  (ref) => throw UnimplementedError(
    'googleOAuthClientConfigProvider must be overridden by the host app',
  ),
);

/// Must be overridden by the host app with its single app-wide shared
/// [Dio] instance — required by [RestFirebaseSignInBackend] so its
/// Identity Toolkit / Google OAuth calls flow through the same client (and
/// the same debug-log interceptor) as the rest of the app's network I/O.
final firebaseSignInSharedDioProvider = Provider<Dio>(
  (ref) => throw UnimplementedError(
    'firebaseSignInSharedDioProvider must be overridden by the host app',
  ),
);

/// Selects a [FirebaseSignInBackend] for the current platform and exposes
/// sign-in/account actions through a single Riverpod entry point.
/// [UnsupportedError] from [DefaultFirebaseOptions.currentPlatform] is the
/// only expected fallback signal — it selects the REST backend.
class FirebaseSignInNotifier extends AsyncNotifier<CloudAccountState> {
  FirebaseSignInBackend? _backend;

  @override
  Future<CloudAccountState> build() async {
    final backend = await _selectBackend();
    await backend.ready();
    _backend = backend;
    return backend.currentState();
  }

  Future<FirebaseSignInBackend> _selectBackend() async {
    try {
      await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform,
      );
      return NativeFirebaseSignInBackend();
    } on UnsupportedError {
      return RestFirebaseSignInBackend(
        apiKey: DefaultFirebaseOptions.web.apiKey,
        googleOAuthClientConfig: ref.read(googleOAuthClientConfigProvider),
        dio: ref.read(firebaseSignInSharedDioProvider),
      );
    }
  }

  Future<void> signInWithEmail(String email, String password) async {
    state = const AsyncLoading();
    try {
      state = AsyncData(await _backend!.signInWithEmail(email, password));
    } catch (error, stackTrace) {
      state = AsyncError(error, stackTrace);
      rethrow;
    }
  }

  Future<void> signUpWithEmail(String email, String password) async {
    state = const AsyncLoading();
    try {
      state = AsyncData(await _backend!.signUpWithEmail(email, password));
    } catch (error, stackTrace) {
      state = AsyncError(error, stackTrace);
      rethrow;
    }
  }

  Future<void> signInWithGoogle({
    void Function(Uri? authUrl)? onManualAuthUrl,
  }) async {
    state = const AsyncLoading();
    try {
      state = AsyncData(
        await _backend!.signInWithGoogle(onManualAuthUrl: onManualAuthUrl),
      );
    } catch (error, stackTrace) {
      state = AsyncError(error, stackTrace);
      rethrow;
    }
  }

  Future<void> signOut() async {
    await _backend!.signOut();
    state = const AsyncData(CloudAccountState());
  }

  Future<void> deleteAccount() async {
    await _backend!.deleteAccount();
    state = const AsyncData(CloudAccountState());
  }

  /// On failure, [RestFirebaseSignInBackend.getIdToken] signs out locally
  /// but can't update [state] itself, so this catch does — otherwise
  /// [state] would keep reporting a stale signed-in [CloudAccountState].
  Future<String?> getIdToken() async {
    try {
      return await _backend!.getIdToken();
    } catch (_) {
      state = const AsyncData(CloudAccountState());
      rethrow;
    }
  }

  bool get isRestBackend => _backend is RestFirebaseSignInBackend;

  /// The active [RestFirebaseSignInBackend], for callers (e.g.
  /// [SignInFlowDialog]) that need to drive its step-based Google
  /// sign-in flow directly. Null on platforms using the native backend.
  RestFirebaseSignInBackend? get restBackendOrNull {
    final backend = _backend;
    return backend is RestFirebaseSignInBackend ? backend : null;
  }

  /// Commits [newState] directly, bypassing [AsyncValue.guard] — used once
  /// a caller-driven flow (e.g. [SignInFlowDialog] running the Google
  /// sign-in steps itself) has completed without throwing, so success is
  /// never silently swallowed the way a guarded `AsyncError` would be.
  void applySignedInState(CloudAccountState newState) {
    state = AsyncData(newState);
  }
}

final firebaseSignInProvider =
    AsyncNotifierProvider<FirebaseSignInNotifier, CloudAccountState>(
      FirebaseSignInNotifier.new,
    );
