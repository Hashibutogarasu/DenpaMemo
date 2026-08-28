import 'package:flutter/material.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

import 'outlined_title.dart';

@widgetbook.UseCase(name: 'Default', type: OutlinedTitleText, path: 'label')
Widget outlinedTitleTextUseCase(BuildContext context) {
  return const OutlinedTitleText(text: 'MAX');
}
