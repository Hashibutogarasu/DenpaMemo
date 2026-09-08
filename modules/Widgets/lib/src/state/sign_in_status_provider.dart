import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Placeholder for whether the current user is signed in.
///
/// This module is domain-agnostic and has no knowledge of the concrete
/// sign-in implementation, so this provider must be overridden by the
/// host app (e.g. with a value derived from its own account provider)
/// before any widget that reads it is built.
final signInStatusProvider = Provider<bool>((ref) {
  throw UnimplementedError(
    'signInStatusProvider must be overridden by the app.',
  );
});
