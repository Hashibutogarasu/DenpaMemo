import 'package:denpamemo_widgets/denpamemo_widgets.dart';
import 'package:flutter/material.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;


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
