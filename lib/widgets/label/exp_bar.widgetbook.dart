import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

import 'exp_bar.dart';

@widgetbook.UseCase(name: 'Default', type: ExpBar, path: 'label')
Widget expBarUseCase(BuildContext context) {
  final value = context.knobs.double.slider(
    label: '進捗値',
    initialValue: 0.5,
    min: 0,
    max: 1,
  );

  return SizedBox(width: 200, child: ExpBar(value: value));
}
