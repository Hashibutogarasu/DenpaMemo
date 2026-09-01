import 'dart:io' show Platform;

import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'cloud_account_state.dart';
import 'exceptions.dart';
import 'firebase_options.dart';
import 'firebase_sign_in_backend.dart';

/// Backend implementation for platforms with a registered native Firebase
/// app — drives `firebase_auth`/`google_sign_in` directly.
class NativeFirebaseSignInBackend implements FirebaseSignInBackend {
  @override
  CloudAccountState currentState() => _fromUser(FirebaseAuth.instance.currentUser);

  @override
  Future<void> ready() async {}

  @override
  Future<CloudAccountState> signInWithEmail(String email, String password) async {
    final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
    return _fromUser(credential.user);
  }

  @override
  Future<CloudAccountState> signUpWithEmail(String email, String password) async {
    final credential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
    return _fromUser(credential.user);
  }

  @override
  Future<CloudAccountState> signInWithGoogle({void Function(Uri? authUrl)? onManualAuthUrl}) async {
    await GoogleSignIn.instance.initialize(
      serverClientId: Platform.isAndroid
          ? DefaultFirebaseOptions.androidGoogleSignInServerClientId
          : null,
    );
    final account = await GoogleSignIn.instance.authenticate();
    final credential = GoogleAuthProvider.credential(idToken: account.authentication.idToken);
    final userCredential = await FirebaseAuth.instance.signInWithCredential(credential);
    return _fromUser(userCredential.user);
  }

  @override
  Future<void> signOut() async {
    await GoogleSignIn.instance.signOut();
    await FirebaseAuth.instance.signOut();
  }

  @override
  Future<String?> getIdToken() => FirebaseAuth.instance.currentUser?.getIdToken() ?? Future.value();

  @override
  Future<void> deleteAccount() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      throw const NotSignedInException();
    }
    await user.delete();
  }

  CloudAccountState _fromUser(User? user) =>
      CloudAccountState(isSignedIn: user != null, email: user?.email, uid: user?.uid);
}
