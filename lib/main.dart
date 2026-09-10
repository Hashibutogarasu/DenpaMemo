import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

import 'package:app_logging/app_logging.dart';
import 'package:data_cache/data_cache.dart';
import 'package:denpamemo_logics/denpamemo_logics.dart';
import 'package:firebase_sign_in/firebase_sign_in.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:package_info_plus/package_info_plus.dart';

import 'app.dart';
import 'bootstrap/google_oauth_config.dart';
import 'data/objectbox/objectbox.dart';
import 'data/settings/objectbox_app_settings_repository.dart';
import 'logging/build_tracker_bridge.dart';
import 'logging/log_file_bridge.dart';
import 'providers/network_providers.dart';
import 'providers/objectbox_providers.dart';

void main() {
  runZonedWithPrintInterceptor(_main);
}

/// Bootstraps native bindings, debug-only logging/build tracking, and the
/// data layer (ObjectBox, cache index, Google OAuth config, Firebase sign-in),
/// then hands the ready instances to [MyApp] and calls [runApp].
Future<void> _main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await RustLib.init();

  if (kDebugMode) {
    installDebugPrintInterceptor();
    installBuildTrackerBridge();
    await installLogFileWriter();
  }

  await initializeDateFormatting();
  final packageInfo = await PackageInfo.fromPlatform();
  final objectBox = await ObjectBox.create();

  if (kDebugMode) {
    debugPrintRebuildDirtyWidgets = ObjectBoxAppSettingsRepository(
      objectBox,
    ).get().buildTrackerEnabled;
  }
  final cacheIndexRepository = await CacheIndexRepository.open(
    packageInfo.packageName,
  );
  final googleOAuthClientConfig = await loadGoogleOAuthClientConfig();
  final sharedDio = createSharedDio();
  final container = ProviderContainer(
    overrides: [
      objectBoxProvider.overrideWithValue(objectBox),
      dataCacheProvider.overrideWithValue(cacheIndexRepository),
      googleOAuthClientConfigProvider.overrideWithValue(
        googleOAuthClientConfig,
      ),
      firebaseSignInSharedDioProvider.overrideWithValue(sharedDio),
    ],
  );
  await container.read(firebaseSignInProvider.future);
  runApp(
    MyApp(
      objectBox: objectBox,
      cacheIndexRepository: cacheIndexRepository,
      overrides: [
        googleOAuthClientConfigProvider.overrideWithValue(
          googleOAuthClientConfig,
        ),
        firebaseSignInSharedDioProvider.overrideWithValue(sharedDio),
        sharedDioProvider.overrideWithValue(sharedDio),
      ],
    ),
  );
}
