import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show Clipboard, ClipboardData;

import '../../i18n/gen/strings.g.dart';

/// A [SnackBar] showing [message] with an action button that copies
/// [copyText] to the clipboard — for messages that hand the user a value
/// (a URL, a code, an ID) they need to paste elsewhere.
class CopyableSnackBar {
  const CopyableSnackBar._();

  static void show(
    BuildContext context, {
    required String message,
    required String copyText,
    Duration duration = const Duration(seconds: 4),
    GlobalKey<ScaffoldMessengerState>? messengerKey,
  }) {
    final messenger = messengerKey?.currentState ?? ScaffoldMessenger.of(context);
    messenger.hideCurrentSnackBar();
    messenger.showSnackBar(
      SnackBar(
        duration: duration,
        content: Text(message),
        action: SnackBarAction(
          label: t.common.copy,
          onPressed: () => Clipboard.setData(ClipboardData(text: copyText)),
        ),
      ),
    );
  }

  static void hide(BuildContext context, {GlobalKey<ScaffoldMessengerState>? messengerKey}) {
    (messengerKey?.currentState ?? ScaffoldMessenger.of(context)).hideCurrentSnackBar();
  }
}
