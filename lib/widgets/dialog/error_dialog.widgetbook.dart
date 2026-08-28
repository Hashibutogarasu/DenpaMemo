import 'package:flutter/material.dart';
import 'package:step_dialog/step_dialog.dart'
    hide Translations, BuildContextTranslationsExtension;
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

import '../../domain/master_data/master_data_load_error.dart';
import '../../i18n/gen/strings.g.dart';
import '../../widgetbook/core/dialog_preview.dart';

@widgetbook.UseCase(name: 'Retriable', type: ErrorDialog, path: 'dialog')
Widget errorDialogRetriableUseCase(BuildContext context) {
  final error = MasterDataConnectionError(onRetry: () async {});
  final t = context.t;
  return DialogPreview(
    builder: (context) => ErrorDialog(
      title: error.title(t),
      description: error.description(t),
      retriable: true,
      onRetry: error.retry,
    ),
  );
}

@widgetbook.UseCase(name: 'NonRetriable', type: ErrorDialog, path: 'dialog')
Widget errorDialogNonRetriableUseCase(BuildContext context) {
  final error = MasterDataConnectionError();
  final t = context.t;
  return DialogPreview(
    builder: (context) =>
        ErrorDialog(title: error.title(t), description: error.description(t)),
  );
}
