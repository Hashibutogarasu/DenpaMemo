import 'package:denpamemo_widgets/denpamemo_widgets.dart';
import 'package:flutter/material.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;
import 'package:denpamemo_widgets/testing.dart';


@widgetbook.UseCase(name: 'Default', type: EditableExp, path: 'denpa_men')
Widget editableExpDefaultUseCase(BuildContext context) {
  return EditableExp(denpaMen: DenpaMenData.denpaMen, onChanged: (_) {});
}

@widgetbook.UseCase(name: 'Max', type: EditableExp, path: 'denpa_men')
Widget editableExpMaxUseCase(BuildContext context) {
  return EditableExp(
    denpaMen: DenpaMenData.denpaMen.copyWith(currentExp: null, maxExp: null),
    onChanged: (_) {},
  );
}
