import 'dart:io' show Platform;

/// Encapsulates every backend URL this app's modules (`AuthApiClient`,
/// `PhysiquesApiClient`, `GraphQlClientFactory`) need but don't know how to
/// choose themselves, so the concrete debug/release choice lives in exactly
/// one place instead of duplicated per-module `kDebugMode`/`Platform`
/// branching. Not configurable via `.env`/`--dart-define` yet, matching the
/// scope this replaces.
abstract class BackendConnectionSettings {
  const BackendConnectionSettings();

  Uri get authServerBaseUrl;
  Uri get apiServerBaseUrl;
  Uri get graphQlEndpoint;
}

/// Points every backend at the developer-facing environment: the `modules/auth`
/// and `modules/server` deployments reachable from an Android device/emulator,
/// or `localhost` on every other platform (desktop debug runs alongside the
/// backend on the same machine).
class DebugBackendConnectionSettings extends BackendConnectionSettings {
  const DebugBackendConnectionSettings();

  @override
  Uri get authServerBaseUrl => Platform.isAndroid
      ? Uri.parse('https://denpamemo-auth-dev.karasu256.com')
      : Uri.parse('http://localhost:8787');

  @override
  Uri get apiServerBaseUrl => Platform.isAndroid
      ? Uri.parse('https://denpamemo-dev.karasu256.com')
      : Uri.parse('http://localhost:4100');

  @override
  Uri get graphQlEndpoint => Platform.isAndroid
      ? Uri.parse('https://denpamemo-dev.karasu256.com/graphql')
      : Uri.parse('http://localhost:4100/graphql');
}

/// Points [authServerBaseUrl] at the (still placeholder, pending real
/// deployment) production `modules/auth` Worker. [apiServerBaseUrl] and
/// [graphQlEndpoint] have no production deployment yet — both back
/// developer-only features (the debug-gated physique table editor) that
/// should never be reached from a release build, so accessing them throws
/// rather than silently pointing a real user's app at a developer machine.
class ReleaseBackendConnectionSettings extends BackendConnectionSettings {
  const ReleaseBackendConnectionSettings();

  @override
  Uri get authServerBaseUrl =>
      Uri.parse('https://denpamemo-auth.karasu256.com');

  @override
  Uri get apiServerBaseUrl => throw UnimplementedError(
    'apiServerBaseUrl has no production deployment yet',
  );

  @override
  Uri get graphQlEndpoint => throw UnimplementedError(
    'graphQlEndpoint has no production deployment yet',
  );
}
