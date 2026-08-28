import 'package:denpamemo_widgets/denpamemo_widgets.dart';
import 'package:flutter/material.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;


@widgetbook.UseCase(
  name: 'Default',
  type: OutlinedInlineNameField,
  path: 'field',
)
Widget outlinedInlineNameFieldUseCase(BuildContext context) {
  return OutlinedInlineNameField(value: 'こうた', onChanged: (_) {});
}
