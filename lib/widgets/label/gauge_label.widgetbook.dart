import 'package:denpamemo_widgets/denpamemo_widgets.dart' hide BuildContextTranslationsExtension;
import 'package:flutter/material.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

import '../../i18n/gen/strings.g.dart';

@widgetbook.UseCase(name: 'Default', type: GaugeLabel, path: 'label')
Widget gaugeLabelUseCase(BuildContext context) {
  return GaugeLabel(
    label: context.t.denpaMenStatus.level,
    value: const GaugeValue(current: 5, max: 10),
  );
}

@widgetbook.UseCase(name: 'Maxed', type: GaugeLabel, path: 'label')
Widget gaugeLabelMaxedUseCase(BuildContext context) {
  return GaugeLabel(
    label: context.t.denpaMenStatus.level,
    value: const GaugeValue(current: 10, max: 10),
  );
}
