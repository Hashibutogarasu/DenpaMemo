import 'package:denpamemo_widgets/denpamemo_widgets.dart';
import 'package:flutter/material.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

@widgetbook.UseCase(name: 'Default', type: DenpaMenNode, path: 'lineage')
Widget denpaMenNodeUseCase(BuildContext context) {
  return const DenpaMenNode(
    icon: SizedBox(width: 64, height: 64),
    name: 'こうた',
    size: 64,
  );
}
