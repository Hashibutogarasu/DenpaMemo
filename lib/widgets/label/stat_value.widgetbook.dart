import 'package:flutter/material.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

import '../../i18n/gen/strings.g.dart';
import 'stat_value.dart';

@widgetbook.UseCase(name: 'Default', type: StatValueLabel, path: 'label')
Widget statValueLabelUseCase(BuildContext context) {
  return SizedBox(
    width: 150,
    child: StatValueLabel(
      label: context.t.stat.attack,
      value: const Text('120'),
    ),
  );
}
