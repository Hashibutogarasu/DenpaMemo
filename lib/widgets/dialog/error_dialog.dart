import 'package:flutter/material.dart';

import '../../domain/app_error.dart';
import '../../i18n/gen/strings.g.dart';

/// Shows [error]'s [AppError.title]/[AppError.description] as a simple
/// acknowledge-and-dismiss dialog: centered title, centered description,
/// an OK button, plus a retry button to its left when
/// [AppError.retriable] is true. Follows the same "public class +
/// static show()" shape as
/// [DenpaMenPreviewDialog](denpa_men_preview_dialog.dart).
///
/// Tapping retry closes the dialog immediately and fires
/// [AppError.retry] in the background rather than waiting on it: if that
/// retry fails, it's up to whatever produced [error] to surface the new
/// failure the same way it surfaced this one (e.g. `masterDataProvider`'s
/// `ref.listen` in `master_data_error_listener.dart` shows a fresh dialog
/// on its own the moment the retried request errors again).
class ErrorDialog extends StatelessWidget {
  const ErrorDialog({super.key, required this.error});

  final AppError error;

  static Future<void> show(BuildContext context, {required AppError error}) {
    return showDialog<void>(
      context: context,
      builder: (context) => ErrorDialog(error: error),
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
              error.title(t),
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 12),
            Text(error.description(t), textAlign: TextAlign.center),
            const SizedBox(height: 20),
            Row(
              children: [
                if (error.retriable) ...[
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () {
                        error.retry().catchError((_) {});
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
