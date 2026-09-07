import 'package:flutter/material.dart';

import '../../i18n/gen/strings.g.dart';
import 'app_dialog.dart';

Future<void> showBirthGuideErrorDialog(
  BuildContext context, {
  required VoidCallback onDismissed,
}) {
  return AppDialog.show<void>(
    context: context,
    builder: (context) => BirthGuideErrorDialog(onDismissed: onDismissed),
  );
}

class BirthGuideErrorDialog extends StatelessWidget {
  const BirthGuideErrorDialog({super.key, required this.onDismissed});

  final VoidCallback onDismissed;

  @override
  Widget build(BuildContext context) {
    final t = context.t;
    return AlertDialog(
      title: Text(t.birthGuide.errorTitle),
      content: Text(t.birthGuide.errorMessage),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
            onDismissed();
          },
          child: Text(t.common.confirm),
        ),
      ],
    );
  }
}
