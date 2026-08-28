import 'package:denpamemo_widgets/denpamemo_widgets.dart' hide BuildContextTranslationsExtension;
import 'package:flutter/material.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

import '../widgetbook/denpa_men/denpa_men_data.dart';

@widgetbook.UseCase(name: 'Default', type: EditableStatGrid, path: 'denpa_men')
Widget editableStatGridUseCase(BuildContext context) {
  return EditableStatGrid(
    denpaMen: DenpaMenData.denpaMen,
    onChanged: (_) {},
    considerCorrections: false,
  );
}
