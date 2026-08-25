import 'package:flutter/material.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

import 'exp_bar.dart';

@widgetbook.UseCase(name: 'Half', type: ExpBar, path: 'label')
Widget expBarHalfUseCase(BuildContext context) {
  return const SizedBox(width: 200, child: ExpBar(value: 0.5));
}

@widgetbook.UseCase(name: 'Full', type: ExpBar, path: 'label')
Widget expBarFullUseCase(BuildContext context) {
  return const SizedBox(width: 200, child: ExpBar(value: 1));
}
