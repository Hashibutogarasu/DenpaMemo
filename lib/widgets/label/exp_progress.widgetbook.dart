import 'package:flutter/material.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

import 'exp_progress.dart';

@widgetbook.UseCase(name: 'InProgress', type: ExpProgress, path: 'label')
Widget expProgressInProgressUseCase(BuildContext context) {
  return const SizedBox(width: 200, child: ExpProgress(progress: 0.4));
}

@widgetbook.UseCase(name: 'Max', type: ExpProgress, path: 'label')
Widget expProgressMaxUseCase(BuildContext context) {
  return const SizedBox(width: 200, child: ExpProgress(progress: null));
}
