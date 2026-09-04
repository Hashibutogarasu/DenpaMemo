import 'package:flutter/material.dart';

import '../../i18n/gen/strings.g.dart';

/// Generic yes/no confirmation dialog for a destructive or otherwise
/// hard-to-undo action, showing [title]/[message] with cancel/confirm
/// buttons. Domain-agnostic: callers own the wording, this widget only
/// owns the yes/no interaction and its result.
class ConfirmDialog extends StatelessWidget {
  const ConfirmDialog({super.key, required this.title, required this.message});

  final String title;
  final String message;

  /// Returns true if the user confirmed, false if they cancelled or
  /// dismissed the dialog.
  static Future<bool> show(
    BuildContext context, {
    required String title,
    required String message,
  }) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => ConfirmDialog(title: title, message: message),
    );
    return confirmed ?? false;
  }

  @override
  Widget build(BuildContext context) {
    final t = context.t;
    return AlertDialog(
      title: Text(title),
      content: Text(message),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(false),
          child: Text(t.common.cancel),
        ),
        TextButton(
          onPressed: () => Navigator.of(context).pop(true),
          child: Text(t.common.confirm),
        ),
      ],
    );
  }
}
