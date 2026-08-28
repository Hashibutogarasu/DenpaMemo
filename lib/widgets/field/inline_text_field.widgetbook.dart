import 'package:denpamemo_widgets/denpamemo_widgets.dart' hide BuildContextTranslationsExtension;
import 'package:flutter/material.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;


@widgetbook.UseCase(name: 'Default', type: InlineTextField, path: 'field')
Widget inlineTextFieldUseCase(BuildContext context) {
  return InlineTextField(value: 'こうた', onChanged: (_) {});
}

@widgetbook.UseCase(name: 'Multiline', type: InlineTextField, path: 'field')
Widget inlineTextFieldMultilineUseCase(BuildContext context) {
  return InlineTextField(value: 'メモの内容', onChanged: (_) {}, multiline: true);
}
