import 'dart:io' show Platform;

import 'package:flutter/services.dart';

const _channel = MethodChannel('com.karasu256.denpamemo/splash');

/// Tells Android's `SplashActivity` the main screen has finished loading,
/// so it can fade out into `MainActivity`. A no-op on every other
/// platform.
void signalNativeSplashReady() {
  if (!Platform.isAndroid) return;
  _channel.invokeMethod('ready');
}
