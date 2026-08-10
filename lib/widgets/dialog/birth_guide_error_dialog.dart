import 'package:flutter/material.dart';

import '../../i18n/gen/strings.g.dart';

Future<void> showBirthGuideErrorDialog(
  BuildContext context, {
  required VoidCallback onDismissed,
}) {
  final t = context.t;
  return showDialog<void>(
    context: context,
    builder: (context) => AlertDialog(
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
    ),
  );
}
