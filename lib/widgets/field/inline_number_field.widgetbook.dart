import 'package:flutter/material.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

import 'inline_number_field.dart';

@widgetbook.UseCase(name: 'Default', type: InlineNumberField, path: 'field')
Widget inlineNumberFieldUseCase(BuildContext context) {
  return InlineNumberField(value: 42, onChanged: (_) {});
}
