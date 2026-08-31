import 'package:flutter/material.dart';

import '../i18n/gen/strings.g.dart';

/// Generic acknowledge-and-dismiss dialog: centered title, centered
/// description, an OK button, plus a retry button to its left when
/// [retriable] is true.
///
/// Tapping retry closes the dialog immediately and fires [onRetry] in the
/// background rather than waiting on it.
class ErrorDialog extends StatelessWidget {
  const ErrorDialog({
    super.key,
    required this.title,
    required this.description,
    this.retriable = false,
    this.onRetry,
  });

  final String title;
  final String description;
  final bool retriable;
  final Future<void> Function()? onRetry;

  static Future<void> show(
    BuildContext context, {
    required String title,
    required String description,
    bool retriable = false,
    Future<void> Function()? onRetry,
  }) {
    return showDialog<void>(
      context: context,
      builder: (context) => ErrorDialog(
        title: title,
        description: description,
        retriable: retriable,
        onRetry: onRetry,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final t = context.t;
    return Dialog(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              title,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 12),
            Text(description, textAlign: TextAlign.center),
            const SizedBox(height: 20),
            Row(
              children: [
                if (retriable) ...[
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () {
                        onRetry?.call().catchError((_) {});
                        Navigator.of(context).pop();
                      },
                      child: Text(t.common.retry),
                    ),
                  ),
                  const SizedBox(width: 12),
                ],
                Expanded(
                  child: FilledButton(
                    onPressed: () => Navigator.of(context).pop(),
                    child: Text(t.common.ok),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
