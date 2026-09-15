import 'dart:async';

import 'package:package_info_plus/package_info_plus.dart';

/// Runs once before every test file under `test/`. Installs a mock
/// [PackageInfo] so platform-dependent storage paths can be resolved without
/// touching the unmocked `package_info_plus` platform channel.
Future<void> testExecutable(FutureOr<void> Function() testMain) async {
  PackageInfo.setMockInitialValues(
    appName: 'denpa_memo',
    packageName: 'com.karasu256.denpamemo',
    version: '0.0.0',
    buildNumber: '0',
    buildSignature: '',
  );
  await testMain();
}
