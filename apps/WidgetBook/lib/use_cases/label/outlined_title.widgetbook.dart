import 'package:denpamemo_widgets/denpamemo_widgets.dart';
import 'package:flutter/material.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;


@widgetbook.UseCase(name: 'Default', type: OutlinedTitleText, path: 'label')
Widget outlinedTitleTextUseCase(BuildContext context) {
  return const OutlinedTitleText(text: 'MAX');
}
