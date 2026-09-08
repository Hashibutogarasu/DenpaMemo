import 'package:flutter/foundation.dart' show kDebugMode;
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../config/backend_connection_settings.dart';

/// The single source every backend-facing provider reads its server URLs
/// from — see [BackendConnectionSettings].
final backendConnectionSettingsProvider = Provider<BackendConnectionSettings>((
  ref,
) {
  return kDebugMode
      ? const DebugBackendConnectionSettings()
      : const ReleaseBackendConnectionSettings();
});
