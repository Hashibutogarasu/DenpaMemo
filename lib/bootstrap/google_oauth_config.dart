import 'dart:convert';

import 'package:flutter/services.dart' show rootBundle;

import 'package:firebase_sign_in/firebase_sign_in.dart';

/// Loads the Google OAuth "Desktop app" client config used by
/// [RestFirebaseSignInBackend]'s Google sign-in loopback flow — bundled as
/// an asset rather than checked into source (see `.gitignore`).
Future<GoogleOAuthClientConfig> loadGoogleOAuthClientConfig() async {
  final raw = await rootBundle.loadString(
    'assets/config/auth/google/google_client_secrets.json',
  );
  return GoogleOAuthClientConfig.fromInstalledAppJson(
    jsonDecode(raw) as Map<String, dynamic>,
  );
}
