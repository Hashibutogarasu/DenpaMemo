import 'package:firebase_sign_in/firebase_sign_in.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/cloud/auth_api_client.dart';
import 'backend_connection_settings_providers.dart';
import 'network_providers.dart';

final authApiClientProvider = Provider<AuthApiClient>(
  (ref) => AuthApiClient(
    ref.watch(backendConnectionSettingsProvider).authServerBaseUrl,
    dio: ref.watch(sharedDioProvider),
  ),
);

/// Thin adapter over [firebaseSignInProvider] that keeps this app's
/// existing synchronous `CloudAccountState`-shaped surface (plain
/// `Notifier` rather than `AsyncNotifier`). [deleteCloudAccount] is
/// app-specific orchestration and stays here rather than in `firebase_sign_in`.
class CloudAccountNotifier extends Notifier<CloudAccountState> {
  @override
  CloudAccountState build() {
    final asyncState = ref.watch(firebaseSignInProvider);
    return asyncState.value ?? const CloudAccountState();
  }

  FirebaseSignInNotifier get _backend =>
      ref.read(firebaseSignInProvider.notifier);

  FirebaseSignInNotifier get firebaseSignIn => _backend;

  Future<void> signInWithEmail(String email, String password) =>
      _backend.signInWithEmail(email, password);

  Future<void> signInWithGoogle({
    void Function(Uri? authUrl)? onManualAuthUrl,
  }) => _backend.signInWithGoogle(onManualAuthUrl: onManualAuthUrl);

  Future<void> signUpWithEmail(String email, String password) =>
      _backend.signUpWithEmail(email, password);

  Future<void> signOut() => _backend.signOut();

  Future<void> deleteCloudAccount() async {
    final idToken = await _backend.getIdToken();
    if (idToken == null) {
      throw const NotSignedInException();
    }
    await ref.read(authApiClientProvider).deleteAccount(idToken);
    await _backend.deleteAccount();
  }
}

final cloudAccountProvider =
    NotifierProvider<CloudAccountNotifier, CloudAccountState>(
      CloudAccountNotifier.new,
    );
