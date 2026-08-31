import 'dart:async';

import 'package:package_info_plus/package_info_plus.dart';

/// Runs once before every test file under `test/`. Installs a mock
/// [PackageInfo] so `PackageInfo.fromPlatform()` (used by
/// `EntityIconStorage`, `ObjectBox.create`, and the icon-cropping widgets to
/// resolve the app's file storage location) resolves without touching the
/// `package_info_plus` platform channel, which is unmocked in the
/// `flutter test` host.
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
