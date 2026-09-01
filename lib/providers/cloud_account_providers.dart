import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../config/auth_config.dart';
import '../data/cloud/auth_api_client.dart';
import '../data/cloud/cloud_auth_exceptions.dart';

/// Whether Firebase was successfully initialized on this platform (see
/// `_initializeFirebase` in `main.dart`, which swallows the
/// [UnsupportedError] thrown on platforms without a registered Firebase
/// app). [FirebaseAuth.instance] throws a `core/no-app` error when this is
/// false, so every entry point below must check it first.
bool get _isFirebaseAvailable => Firebase.apps.isNotEmpty;

final authApiClientProvider = Provider<AuthApiClient>(
  (ref) => AuthApiClient(Uri.parse(authBaseUrl)),
);

/// Sign-in state for the account's cloud (Firebase) identity, kept
/// separate from `account_providers.dart`'s local/ObjectBox account since
/// the two have entirely different lifecycles.
class CloudAccountState {
  const CloudAccountState({
    this.isSignedIn = false,
    this.email,
    this.uid,
    this.isLoading = false,
  });

  final bool isSignedIn;
  final String? email;
  final String? uid;
  final bool isLoading;

  CloudAccountState copyWith({bool? isLoading}) => CloudAccountState(
    isSignedIn: isSignedIn,
    email: email,
    uid: uid,
    isLoading: isLoading ?? this.isLoading,
  );
}

/// Drives sign-in/sign-up/sign-out and cloud account deletion via
/// `firebase_auth`/`google_sign_in` directly — `modules/auth` is only
/// involved in [deleteCloudAccount], to remove the account's R2 files.
/// Callers (dialogs) are expected to catch any thrown exception
/// themselves and show it via the app's existing error dialog.
class CloudAccountNotifier extends Notifier<CloudAccountState> {
  @override
  CloudAccountState build() => _isFirebaseAvailable
      ? _fromUser(FirebaseAuth.instance.currentUser)
      : const CloudAccountState();

  Future<void> signInWithEmail(String email, String password) async {
    if (!_isFirebaseAvailable) {
      throw const CloudUnavailableException();
    }
    state = state.copyWith(isLoading: true);
    try {
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      state = _fromUser(credential.user);
    } catch (_) {
      state = state.copyWith(isLoading: false);
      rethrow;
    }
  }

  Future<void> signInWithGoogle() async {
    if (!_isFirebaseAvailable) {
      throw const CloudUnavailableException();
    }
    state = state.copyWith(isLoading: true);
    try {
      await GoogleSignIn.instance.initialize();
      final account = await GoogleSignIn.instance.authenticate();
      final credential = GoogleAuthProvider.credential(
        idToken: account.authentication.idToken,
      );
      final userCredential = await FirebaseAuth.instance.signInWithCredential(credential);
      state = _fromUser(userCredential.user);
    } on GoogleSignInException catch (error) {
      state = state.copyWith(isLoading: false);
      if (error.code == GoogleSignInExceptionCode.canceled) {
        return;
      }
      rethrow;
    } catch (_) {
      state = state.copyWith(isLoading: false);
      rethrow;
    }
  }

  Future<void> signUpWithEmail(String email, String password) async {
    if (!_isFirebaseAvailable) {
      throw const CloudUnavailableException();
    }
    state = state.copyWith(isLoading: true);
    try {
      final credential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      state = _fromUser(credential.user);
    } catch (_) {
      state = state.copyWith(isLoading: false);
      rethrow;
    }
  }

  Future<void> signOut() async {
    if (!_isFirebaseAvailable) {
      throw const CloudUnavailableException();
    }
    await GoogleSignIn.instance.signOut();
    await FirebaseAuth.instance.signOut();
    state = const CloudAccountState();
  }

  Future<void> deleteCloudAccount() async {
    if (!_isFirebaseAvailable) {
      throw const CloudUnavailableException();
    }
    final idToken = await FirebaseAuth.instance.currentUser?.getIdToken();
    if (idToken == null) {
      throw const NotSignedInException();
    }
    await ref.read(authApiClientProvider).deleteAccount(idToken);
    await FirebaseAuth.instance.currentUser?.delete();
    state = const CloudAccountState();
  }

  CloudAccountState _fromUser(User? user) =>
      CloudAccountState(isSignedIn: user != null, email: user?.email, uid: user?.uid);
}

final cloudAccountProvider = NotifierProvider<CloudAccountNotifier, CloudAccountState>(
  CloudAccountNotifier.new,
);
