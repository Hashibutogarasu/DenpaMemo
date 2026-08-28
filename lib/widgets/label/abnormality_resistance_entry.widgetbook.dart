import 'package:denpamemo_widgets/denpamemo_widgets.dart' hide BuildContextTranslationsExtension;
import 'package:flutter/material.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

import '../../i18n/gen/strings.g.dart';

@widgetbook.UseCase(name: 'Positive', type: AbnormalityResistanceEntry, path: 'label')
Widget abnormalityResistanceEntryPositiveUseCase(BuildContext context) {
  const abnormalityId = 'poison';
  return AbnormalityResistanceEntry(
    label: context.t.abnormality[abnormalityId] ?? abnormalityId,
    value: 30,
  );
}

@widgetbook.UseCase(name: 'Negative', type: AbnormalityResistanceEntry, path: 'label')
Widget abnormalityResistanceEntryNegativeUseCase(BuildContext context) {
  const abnormalityId = 'paralysis';
  return AbnormalityResistanceEntry(
    label: context.t.abnormality[abnormalityId] ?? abnormalityId,
    value: -20,
  );
}
