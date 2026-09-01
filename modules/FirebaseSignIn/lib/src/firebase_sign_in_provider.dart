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
  (ref) => throw UnimplementedError('googleOAuthClientConfigProvider must be overridden by the host app'),
);

/// Selects a [FirebaseSignInBackend] for the current platform and exposes
/// sign-in/account actions through a single Riverpod entry point.
///
/// [UnsupportedError] from [DefaultFirebaseOptions.currentPlatform] is the
/// only expected, documented fallback signal — it selects the REST
/// backend, itself a complete implementation rather than a no-op. Any
/// other exception during backend selection propagates and surfaces as an
/// [AsyncError] instead of being swallowed.
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
      await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
      return NativeFirebaseSignInBackend();
    } on UnsupportedError {
      return RestFirebaseSignInBackend(
        apiKey: DefaultFirebaseOptions.web.apiKey,
        googleOAuthClientConfig: ref.read(googleOAuthClientConfigProvider),
      );
    }
  }

  Future<void> signInWithEmail(String email, String password) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() => _backend!.signInWithEmail(email, password));
  }

  Future<void> signUpWithEmail(String email, String password) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() => _backend!.signUpWithEmail(email, password));
  }

  Future<void> signInWithGoogle() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() => _backend!.signInWithGoogle());
  }

  Future<void> signOut() async {
    await _backend!.signOut();
    state = const AsyncData(CloudAccountState());
  }

  Future<void> deleteAccount() async {
    await _backend!.deleteAccount();
    state = const AsyncData(CloudAccountState());
  }

  Future<String?> getIdToken() => _backend!.getIdToken();
}

final firebaseSignInProvider = AsyncNotifierProvider<FirebaseSignInNotifier, CloudAccountState>(
  FirebaseSignInNotifier.new,
);
