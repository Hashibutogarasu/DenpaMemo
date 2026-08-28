import 'package:flutter/material.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

import 'inline_nullable_number_field.dart';

@widgetbook.UseCase(
  name: 'Default',
  type: InlineNullableNumberField,
  path: 'field',
)
Widget inlineNullableNumberFieldUseCase(BuildContext context) {
  return InlineNullableNumberField(value: 10, onChanged: (_) {});
}

@widgetbook.UseCase(
  name: 'Empty',
  type: InlineNullableNumberField,
  path: 'field',
)
Widget inlineNullableNumberFieldEmptyUseCase(BuildContext context) {
  return InlineNullableNumberField(value: null, onChanged: (_) {});
}
