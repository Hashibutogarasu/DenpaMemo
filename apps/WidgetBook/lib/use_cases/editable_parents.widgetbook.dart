import 'package:flutter/material.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;
import 'package:denpamemo_widgets/testing.dart';
import 'package:denpamemo_widgets/denpamemo_widgets.dart';


@widgetbook.UseCase(name: 'Default', type: EditableParents, path: 'denpa_men')
Widget editableParentsUseCase(BuildContext context) {
  return EditableParents(
    denpaMen: DenpaMenData.denpaMen,
    records: const [],
    onPickParents: (_) async => null,
    onChanged: (_) {},
  );
}
