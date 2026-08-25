import 'package:flutter/material.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

import '../widgetbook/denpa_men/denpa_men_data.dart';
import 'editable_stat_grid.dart';

@widgetbook.UseCase(name: 'Default', type: EditableStatGrid, path: 'denpa_men')
Widget editableStatGridUseCase(BuildContext context) {
  return EditableStatGrid(
    denpaMen: DenpaMenData.denpaMen,
    onChanged: (_) {},
    considerCorrections: false,
  );
}
