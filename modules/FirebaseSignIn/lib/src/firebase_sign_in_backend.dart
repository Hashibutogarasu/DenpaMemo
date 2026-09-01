import 'cloud_account_state.dart';

/// A sign-in/account backend, implemented once against native Firebase SDKs
/// and once against the Firebase Identity Toolkit REST API, so callers can
/// depend on this interface without caring which platform they're on.
abstract interface class FirebaseSignInBackend {
  /// Best-effort snapshot of the current session, read synchronously
  /// without a network round-trip.
  CloudAccountState currentState();

  /// Completes once any persisted/native session has been restored.
  /// Callers await this before trusting [currentState].
  Future<void> ready();

  Future<CloudAccountState> signInWithEmail(String email, String password);

  Future<CloudAccountState> signUpWithEmail(String email, String password);

  Future<CloudAccountState> signInWithGoogle();

  Future<void> signOut();

  /// Returns null if not signed in. Refreshes an expired token before
  /// returning rather than silently returning a stale one.
  Future<String?> getIdToken();

  /// Deletes the underlying Firebase Auth user. Throws
  /// [NotSignedInException] if nobody is signed in.
  Future<void> deleteAccount();
}
