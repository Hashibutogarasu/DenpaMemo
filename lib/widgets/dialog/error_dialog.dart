import 'package:flutter/material.dart';

import '../../domain/backup/dm_import_error.dart';
import '../../i18n/gen/strings.g.dart';

/// Shows [error]'s [DmImportError.title]/[DmImportError.description] as a
/// simple acknowledge-and-dismiss dialog: centered title, centered
/// description, a single OK button. Follows the same
/// "public class + static show()" shape as
/// [DenpaMenPreviewDialog](denpa_men_preview_dialog.dart).
class ErrorDialog extends StatelessWidget {
  const ErrorDialog({super.key, required this.error});

  final DmImportError error;

  static Future<void> show(BuildContext context, {required DmImportError error}) {
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
            SizedBox(
              width: double.infinity,
              child: FilledButton(
                onPressed: () => Navigator.of(context).pop(),
                child: Text(t.common.ok),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
