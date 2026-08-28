import 'package:flutter/material.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

import '../../widgetbook/core/dialog_preview.dart';
import 'bottom_slide_dialog.dart';

@widgetbook.UseCase(name: 'Default', type: BottomSlideDialog, path: 'dialog')
Widget bottomSlideDialogUseCase(BuildContext context) {
  return DialogPreview(
    builder: (context) => BottomSlideDialog(
      title: 'タイトル',
      onConfirm: () {},
      content: const SizedBox(
        height: 120,
        child: Center(child: Text('コンテンツ')),
      ),
    ),
  );
}

@widgetbook.UseCase(name: 'ConfirmDisabled', type: BottomSlideDialog, path: 'dialog')
Widget bottomSlideDialogConfirmDisabledUseCase(BuildContext context) {
  return DialogPreview(
    builder: (context) => BottomSlideDialog(
      title: 'タイトル',
      confirmEnabled: false,
      onConfirm: () {},
      content: const SizedBox(
        height: 120,
        child: Center(child: Text('コンテンツ')),
      ),
    ),
  );
}
