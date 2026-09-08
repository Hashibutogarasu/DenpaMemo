import 'dart:io';

import 'package:flutter/foundation.dart' show kReleaseMode;
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

const _channel = MethodChannel('com.karasu256.denpamemo/app_config');

/// One of `playstore-internal`, `playstore-beta`, `playstore`, `release`, or
/// `debug` — Android's `BuildConfig.RELEASE_CHANNEL`, set by the build that
/// produced the running APK (see `android/app/build.gradle.kts`). On
/// platforms without that native bridge, falls back to `release`/`debug`
/// based on the Dart build mode.
final releaseChannelProvider = FutureProvider<String>((ref) async {
  if (!Platform.isAndroid) {
    return kReleaseMode ? 'release' : 'debug';
  }
  final channel = await _channel.invokeMethod<String>('getReleaseChannel');
  return channel ?? (kReleaseMode ? 'release' : 'debug');
});
