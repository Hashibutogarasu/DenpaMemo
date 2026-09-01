import 'package:flutter/foundation.dart' show kDebugMode;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show Clipboard, ClipboardData;
import 'package:toaster/toaster.dart';

import '../i18n/gen/strings.g.dart';

/// Generic acknowledge-and-dismiss dialog: title, description, then a
/// vertical stack of buttons (retry when [retriable], copy, OK). Tapping
/// retry closes the dialog and fires [onRetry] in the background.
class ErrorDialog extends StatelessWidget {
  const ErrorDialog({
    super.key,
    required this.title,
    required this.description,
    this.retriable = false,
    this.onRetry,
    this.stackTrace,
  });

  final String title;
  final String description;
  final bool retriable;
  final Future<void> Function()? onRetry;
  final StackTrace? stackTrace;

  static Future<void> show(
    BuildContext context, {
    required String title,
    required String description,
    bool retriable = false,
    Future<void> Function()? onRetry,
    StackTrace? stackTrace,
  }) {
    return showDialog<void>(
      context: context,
      builder: (context) => ErrorDialog(
        title: title,
        description: description,
        retriable: retriable,
        onRetry: onRetry,
        stackTrace: stackTrace,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final t = context.t;
    final copyLabel = kDebugMode ? t.common.copyError : t.common.copyMessage;
    final copyText = kDebugMode && stackTrace != null ? '$description\n\n$stackTrace' : description;
    return Dialog(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              title,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 12),
            Text(description, textAlign: TextAlign.center),
            const SizedBox(height: 20),
            if (retriable) ...[
              OutlinedButton(
                onPressed: () {
                  onRetry?.call().catchError((_) {});
                  Navigator.of(context).pop();
                },
                child: Text(t.common.retry),
              ),
              const SizedBox(height: 12),
            ],
            OutlinedButton(
              onPressed: () async {
                await Clipboard.setData(ClipboardData(text: copyText));
                if (!context.mounted) return;
                await Toaster.show(context, t.common.copiedToast(label: copyLabel));
              },
              child: Text(copyLabel),
            ),
            const SizedBox(height: 12),
            FilledButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text(t.common.ok),
            ),
          ],
        ),
      ),
    );
  }
}
