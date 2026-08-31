import 'package:denpamemo_widgets/denpamemo_widgets.dart';
import 'package:flutter/material.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;


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
