import 'dart:async';
import 'dart:io';

import 'package:denpamemo_logics/denpamemo_logics.dart';
import 'package:flutter_rust_bridge/flutter_rust_bridge_for_generated.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:path/path.dart' as path;

/// The native library `cargo build` produces for `modules/denpamemo_logics`
/// on the host platform running `flutter test` — built by `setup.sh`, the
/// same way it fetches ObjectBox's native library for this same host.
String _hostRustLibraryPath() {
  final targetDir = path.join('modules', 'denpamemo_logics', 'rust', 'target', 'debug');
  if (Platform.isMacOS) return path.join(targetDir, 'libdenpamemo_logics.dylib');
  if (Platform.isWindows) return path.join(targetDir, 'denpamemo_logics.dll');
  return path.join(targetDir, 'libdenpamemo_logics.so');
}

/// Runs once before every test file under `test/`. Installs a mock
/// [PackageInfo] so `PackageInfo.fromPlatform()` (used by
/// `EntityIconStorage`, `ObjectBox.create`, and the icon-cropping widgets to
/// resolve the app's file storage location) resolves without touching the
/// `package_info_plus` platform channel, which is unmocked in the
/// `flutter test` host. Also loads `denpamemo_logics`'s native library
/// directly from its build output, so tests never depend on the host's
/// dynamic-library search path (e.g. `LD_LIBRARY_PATH`) being configured.
Future<void> testExecutable(FutureOr<void> Function() testMain) async {
  PackageInfo.setMockInitialValues(
    appName: 'denpa_memo',
    packageName: 'com.karasu256.denpamemo',
    version: '0.0.0',
    buildNumber: '0',
    buildSignature: '',
  );
  await RustLib.init(externalLibrary: ExternalLibrary.open(_hostRustLibraryPath()));
  await testMain();
}
