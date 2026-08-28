import 'package:denpamemo_widgets/denpamemo_widgets.dart' hide BuildContextTranslationsExtension;
import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

import '../../i18n/gen/strings.g.dart';

@widgetbook.UseCase(name: 'Default', type: GaugeValue, path: 'label')
Widget gaugeValueUseCase(BuildContext context) {
  final current = context.knobs.int.slider(
    label: 'current',
    initialValue: 5,
    min: 0,
    max: 20,
  );
  final max = context.knobs.int.slider(
    label: 'max',
    initialValue: 20,
    min: 1,
    max: 20,
  );

  return GaugeLabel(
    label: context.t.denpaMenStatus.level,
    value: GaugeValue(current: current, max: max),
  );
}
