import 'package:denpamemo_widgets/denpamemo_widgets.dart';
import 'package:flutter/material.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;


@widgetbook.UseCase(name: 'Default', type: InlineGaugeLabel, path: 'label')
Widget inlineGaugeLabelUseCase(BuildContext context) {
  return InlineGaugeLabel(
    label: context.t.denpaMenStatus.level,
    value: const GaugeValue(current: 3, max: 10),
    onCurrentChanged: (_) {},
    onMaxChanged: (_) {},
  );
}
