import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;

/// The half of `DefaultFirebaseOptions` that differs between build types:
/// [web], [android], and the `serverClientId` `google_sign_in` needs on
/// Android (`google-services.json`'s `client_type: 3` entry). See
/// `firebase_options.dart` for the concrete debug/release values.
abstract class FirebaseConnectionSettings {
  const FirebaseConnectionSettings();

  FirebaseOptions get web;
  FirebaseOptions get android;
  String get androidGoogleSignInServerClientId;
}
