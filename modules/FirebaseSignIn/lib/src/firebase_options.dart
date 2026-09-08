import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kDebugMode, kIsWeb, TargetPlatform;

import 'firebase_connection_settings.dart';

/// Points [web]/[android] at the `denpa-memo-dev` Firebase project's
/// `Denpamemo (Web Debug)`/`com.karasu256.denpamemo.debug` apps.
class DebugFirebaseConnectionSettings extends FirebaseConnectionSettings {
  const DebugFirebaseConnectionSettings();

  @override
  FirebaseOptions get web => const FirebaseOptions(
    apiKey: 'AIzaSyDLAfeBBJDMzyt6tT6YGtv4ay6uDEMnVnw',
    appId: '1:572030684127:web:9e4abde0d36b7a9a09926a',
    messagingSenderId: '572030684127',
    projectId: 'denpa-memo-dev',
    authDomain: 'denpa-memo-dev.firebaseapp.com',
    storageBucket: 'denpa-memo-dev.firebasestorage.app',
    measurementId: 'G-E9854886FD',
  );

  @override
  FirebaseOptions get android => const FirebaseOptions(
    apiKey: 'AIzaSyCPU42_M0wczrox_YgczfiXwFvUITAplVA',
    appId: '1:572030684127:android:7fe0373198c4e86d09926a',
    messagingSenderId: '572030684127',
    projectId: 'denpa-memo-dev',
    storageBucket: 'denpa-memo-dev.firebasestorage.app',
  );

  @override
  String get androidGoogleSignInServerClientId =>
      '572030684127-m2qfnak23sqgirv5vg90idve8cp7fnlj.apps.googleusercontent.com';
}

/// Points [web]/[android] at the `denpa-memo-29dda` Firebase project's
/// web/`com.karasu256.denpamemo` apps.
class ReleaseFirebaseConnectionSettings extends FirebaseConnectionSettings {
  const ReleaseFirebaseConnectionSettings();

  @override
  FirebaseOptions get web => const FirebaseOptions(
    apiKey: 'AIzaSyAbU1MUAo8EHulSCKNtRi7ORoZpJAagTOE',
    appId: '1:18613508464:web:8b50cdf5bbb20bee2c97b5',
    messagingSenderId: '18613508464',
    projectId: 'denpa-memo-29dda',
    authDomain: 'denpa-memo-29dda.firebaseapp.com',
    storageBucket: 'denpa-memo-29dda.firebasestorage.app',
    measurementId: 'G-ZDVZ978FP9',
  );

  @override
  FirebaseOptions get android => const FirebaseOptions(
    apiKey: 'AIzaSyC1frXH4mkYsmnNUQIvCuAkCxSOKxSQwCQ',
    appId: '1:18613508464:android:887b3c6c41ad24ae2c97b5',
    messagingSenderId: '18613508464',
    projectId: 'denpa-memo-29dda',
    storageBucket: 'denpa-memo-29dda.firebasestorage.app',
  );

  @override
  String get androidGoogleSignInServerClientId =>
      '18613508464-m03ka3ndd8pi7j9kjibkpgqr22r91qkk.apps.googleusercontent.com';
}

/// Firebase project configuration, in the shape the FlutterFire CLI itself
/// generates. Resolved through [FirebaseConnectionSettings] so the
/// debug/release split lives in exactly one place ([currentPlatform] and
/// [web]/[androidGoogleSignInServerClientId] all read from it).
class DefaultFirebaseOptions {
  const DefaultFirebaseOptions._();

  static FirebaseConnectionSettings get _connectionSettings => kDebugMode
      ? const DebugFirebaseConnectionSettings()
      : const ReleaseFirebaseConnectionSettings();

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
        return _connectionSettings.android;
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

  static FirebaseOptions get web => _connectionSettings.web;

  static String get androidGoogleSignInServerClientId =>
      _connectionSettings.androidGoogleSignInServerClientId;
}
