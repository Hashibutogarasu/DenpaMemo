import 'package:denpamemo_widgets/denpamemo_widgets.dart' hide BuildContextTranslationsExtension;
import 'package:flutter/material.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

import '../../i18n/gen/strings.g.dart';

@widgetbook.UseCase(name: 'Positive', type: AttributeResistanceEntry, path: 'label')
Widget attributeResistanceEntryPositiveUseCase(BuildContext context) {
  const attributeId = 'fire';
  return SizedBox(
    width: 150,
    child: AttributeResistanceEntry(
      label: context.t.attribute[attributeId] ?? attributeId,
      value: 25,
    ),
  );
}

@widgetbook.UseCase(name: 'Negative', type: AttributeResistanceEntry, path: 'label')
Widget attributeResistanceEntryNegativeUseCase(BuildContext context) {
  const attributeId = 'ice';
  return SizedBox(
    width: 150,
    child: AttributeResistanceEntry(
      label: context.t.attribute[attributeId] ?? attributeId,
      value: -15,
    ),
  );
}
