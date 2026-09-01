import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart' show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Firebase project configuration, in the shape the FlutterFire CLI itself
/// generates. Only [web] and [android] are populated, from apps actually
/// registered in the Firebase console — every other platform needs its own
/// registered app and generated config, since a platform's `appId` (and
/// often `apiKey`) differs per platform; reusing another platform's values
/// there would silently fail at runtime. [androidGoogleSignInServerClientId]
/// is the Web OAuth client ID `google_sign_in` needs as `serverClientId`
/// on Android (`google-services.json`'s `client_type: 3` entry).
class DefaultFirebaseOptions {
  const DefaultFirebaseOptions._();

  /// Throws [UnsupportedError] for any platform without a registered
  /// Firebase app — callers use this to decide whether native Firebase can
  /// be initialized at all, falling back to a REST-based implementation
  /// otherwise.
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
      case TargetPlatform.macOS:
      case TargetPlatform.windows:
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for '
          '$defaultTargetPlatform - only web and android apps have been '
          'registered in the Firebase console so far. Register this '
          'platform in the Firebase console (or run the FlutterFire CLI) '
          'and add its options here.',
        );
      case TargetPlatform.fuchsia:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const web = FirebaseOptions(
    apiKey: 'AIzaSyAbU1MUAo8EHulSCKNtRi7ORoZpJAagTOE',
    appId: '1:18613508464:web:8b50cdf5bbb20bee2c97b5',
    messagingSenderId: '18613508464',
    projectId: 'denpa-memo-29dda',
    authDomain: 'denpa-memo-29dda.firebaseapp.com',
    storageBucket: 'denpa-memo-29dda.firebasestorage.app',
    measurementId: 'G-ZDVZ978FP9',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyC1frXH4mkYsmnNUQIvCuAkCxSOKxSQwCQ',
    appId: '1:18613508464:android:887b3c6c41ad24ae2c97b5',
    messagingSenderId: '18613508464',
    projectId: 'denpa-memo-29dda',
    storageBucket: 'denpa-memo-29dda.firebasestorage.app',
  );

  static const androidGoogleSignInServerClientId =
      '18613508464-m03ka3ndd8pi7j9kjibkpgqr22r91qkk.apps.googleusercontent.com';
}
