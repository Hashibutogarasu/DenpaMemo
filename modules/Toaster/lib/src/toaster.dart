import 'dart:io' show Platform;

import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/widgets.dart';
import 'package:flutter_toast_notification/flutter_toast_notification.dart';
import 'package:fluttertoast/fluttertoast.dart';

/// Shows a short toast message. `fluttertoast` has no Linux implementation,
/// so on Linux this falls back to `flutter_toast_notification` (which needs
/// a [BuildContext] with an [Overlay] above it) instead.
class Toaster {
  const Toaster._();

  static Future<void> show(BuildContext context, String message) async {
    if (!kIsWeb && Platform.isLinux) {
      FlutterToast().show(context, message);
      return;
    }
    await Fluttertoast.showToast(msg: message);
  }
}
