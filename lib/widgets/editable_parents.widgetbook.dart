import 'package:flutter/material.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

import '../widgetbook/denpa_men/denpa_men_data.dart';
import 'editable_parents.dart';

@widgetbook.UseCase(name: 'Default', type: EditableParents, path: 'denpa_men')
Widget editableParentsUseCase(BuildContext context) {
  return EditableParents(
    denpaMen: DenpaMenData.denpaMen,
    masterData: DenpaMenData.masterData,
    onChanged: (_) {},
  );
}
