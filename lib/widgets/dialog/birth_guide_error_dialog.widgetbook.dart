import 'package:denpamemo_widgets/denpamemo_widgets.dart' hide BuildContextTranslationsExtension;
import 'package:flutter/material.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

import '../../widgetbook/core/dialog_preview.dart';

@widgetbook.UseCase(name: 'Default', type: BirthGuideErrorDialog, path: 'dialog')
Widget birthGuideErrorDialogUseCase(BuildContext context) {
  return DialogPreview(
    builder: (context) => BirthGuideErrorDialog(onDismissed: () {}),
  );
}
