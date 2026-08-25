import 'package:flutter/material.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

import '../../domain/master_data/master_data_load_error.dart';
import 'error_dialog.dart';

@widgetbook.UseCase(name: 'Retriable', type: ErrorDialog, path: 'dialog')
Widget errorDialogRetriableUseCase(BuildContext context) {
  return ErrorDialog(error: MasterDataConnectionError(onRetry: () async {}));
}

@widgetbook.UseCase(name: 'NonRetriable', type: ErrorDialog, path: 'dialog')
Widget errorDialogNonRetriableUseCase(BuildContext context) {
  return const ErrorDialog(error: MasterDataConnectionError());
}
