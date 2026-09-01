import 'package:flutter/material.dart';

import '../../i18n/gen/strings.g.dart';

/// A generic OK/cancel confirmation dialog.
class ConfirmDialog extends StatelessWidget {
  const ConfirmDialog({super.key, required this.title, required this.message});

  final String title;
  final String message;

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
