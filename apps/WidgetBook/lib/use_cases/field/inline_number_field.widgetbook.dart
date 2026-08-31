import 'package:denpamemo_widgets/denpamemo_widgets.dart';
import 'package:flutter/material.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;


@widgetbook.UseCase(name: 'Default', type: InlineNumberField, path: 'field')
Widget inlineNumberFieldUseCase(BuildContext context) {
  return InlineNumberField(value: 42, onChanged: (_) {});
}
