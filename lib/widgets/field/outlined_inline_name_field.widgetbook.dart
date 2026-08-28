import 'package:flutter/material.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

import 'outlined_inline_name_field.dart';

@widgetbook.UseCase(
  name: 'Default',
  type: OutlinedInlineNameField,
  path: 'field',
)
Widget outlinedInlineNameFieldUseCase(BuildContext context) {
  return OutlinedInlineNameField(value: 'こうた', onChanged: (_) {});
}
