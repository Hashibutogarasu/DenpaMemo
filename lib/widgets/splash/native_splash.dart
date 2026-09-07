import 'dart:io' show Platform;

import 'package:flutter/services.dart';

const _channel = MethodChannel('com.karasu256.denpamemo/splash');

/// Tells Android's `MainActivity` the main screen has finished loading, so
/// it can fade out the native splash overlay drawn on top of the Flutter
/// content. A no-op on every other platform.
void signalNativeSplashReady() {
  if (!Platform.isAndroid) return;
  _channel.invokeMethod('ready');
}
