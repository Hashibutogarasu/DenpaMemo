/// Thrown when a cloud operation requires a signed-in Firebase user but
/// none is currently signed in.
class NotSignedInException implements Exception {
  const NotSignedInException();

  @override
  String toString() => 'NotSignedInException: no Firebase user is signed in';
}

/// Thrown when a cloud operation is attempted on a platform where Firebase
/// has not been initialized (see [DefaultFirebaseOptions.currentPlatform]).
class CloudUnavailableException implements Exception {
  const CloudUnavailableException();

  @override
  String toString() =>
      'CloudUnavailableException: Firebase is not initialized on this platform';
}
