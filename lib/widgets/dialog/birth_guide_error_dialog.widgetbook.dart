import 'package:flutter/material.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

import '../../widgetbook/core/dialog_preview.dart';
import 'birth_guide_error_dialog.dart';

@widgetbook.UseCase(name: 'Default', type: BirthGuideErrorDialog, path: 'dialog')
Widget birthGuideErrorDialogUseCase(BuildContext context) {
  return DialogPreview(
    builder: (context) => BirthGuideErrorDialog(onDismissed: () {}),
  );
}
