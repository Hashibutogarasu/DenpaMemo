import 'package:flutter/material.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

import 'app_back_button.dart';

@widgetbook.UseCase(name: 'Default', type: AppBackButton, path: 'navigation')
Widget appBackButtonUseCase(BuildContext context) {
  return AppBackButton(onPressed: () {});
}
