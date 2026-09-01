/// Thrown when a cloud operation requires a signed-in user but none is
/// currently signed in.
class NotSignedInException implements Exception {
  const NotSignedInException();

  @override
  String toString() => 'NotSignedInException: no user is signed in';
}

/// Thrown when neither the native nor the REST backend could be
/// constructed for the current platform.
class CloudSignInUnavailableException implements Exception {
  const CloudSignInUnavailableException(this.message);

  final String message;

  @override
  String toString() => 'CloudSignInUnavailableException: $message';
}

/// Thrown when the desktop OAuth loopback flow used by the REST backend's
/// Google sign-in fails: the user denied consent, the `state` parameter
/// did not match, or the flow timed out waiting for the redirect.
class GoogleSignInLoopbackException implements Exception {
  const GoogleSignInLoopbackException(this.message);

  final String message;

  @override
  String toString() => 'GoogleSignInLoopbackException: $message';
}

/// Wraps a Firebase Identity Toolkit / Secure Token REST API error
/// response, preserving the original status code and error code so
/// callers see the real reason (e.g. `INVALID_LOGIN_CREDENTIALS`) instead
/// of a generic failure.
class RestAuthException implements Exception {
  const RestAuthException({required this.statusCode, required this.errorCode, this.rawMessage});

  final int statusCode;
  final String errorCode;
  final String? rawMessage;

  @override
  String toString() => 'RestAuthException($statusCode): $errorCode${rawMessage != null ? ' ($rawMessage)' : ''}';
}
