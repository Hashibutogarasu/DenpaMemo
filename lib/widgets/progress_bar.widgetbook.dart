import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

import 'progress_bar.dart';

@widgetbook.UseCase(name: 'Default', type: ProgressBar, path: 'common')
Widget progressBarUseCase(BuildContext context) {
  final indeterminate = context.knobs.boolean(
    label: '不確定（indeterminate）',
    initialValue: false,
  );
  final value = context.knobs.double.slider(
    label: '進捗値',
    initialValue: 0.6,
    min: 0,
    max: 1,
  );

  return ProgressBar(value: indeterminate ? null : value);
}
