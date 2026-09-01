import 'package:denpamemo_widgets/denpamemo_widgets.dart';
import 'package:flutter/material.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

@widgetbook.UseCase(name: 'Default', type: CopyableSnackBar, path: 'snackbar')
Widget copyableSnackBarUseCase(BuildContext context) {
  return Scaffold(
    body: Center(
      child: ElevatedButton(
        onPressed: () => CopyableSnackBar.show(
          context,
          message: 'https://example.com/auth?state=abcdef を開いて認証してください。',
          copyText: 'https://example.com/auth?state=abcdef',
        ),
        child: const Text('Show'),
      ),
    ),
  );
}
