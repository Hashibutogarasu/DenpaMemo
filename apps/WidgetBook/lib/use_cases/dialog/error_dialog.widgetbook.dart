import 'package:flutter/material.dart';
import 'package:step_dialog/step_dialog.dart'
    hide Translations, BuildContextTranslationsExtension;
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;
import '../../core/dialog_preview.dart';

@widgetbook.UseCase(name: 'Retriable', type: ErrorDialog, path: 'dialog')
Widget errorDialogRetriableUseCase(BuildContext context) {
  return DialogPreview(
    builder: (context) => ErrorDialog(
      title: 'サーバーに接続できません',
      description: 'サーバーに接続できませんでした。サーバーが起動しているか、接続先を確認してください。',
      retriable: true,
      onRetry: () async {},
    ),
  );
}

@widgetbook.UseCase(name: 'NonRetriable', type: ErrorDialog, path: 'dialog')
Widget errorDialogNonRetriableUseCase(BuildContext context) {
  return DialogPreview(
    builder: (context) => const ErrorDialog(
      title: 'サーバーに接続できません',
      description: 'サーバーに接続できませんでした。サーバーが起動しているか、接続先を確認してください。',
    ),
  );
}
