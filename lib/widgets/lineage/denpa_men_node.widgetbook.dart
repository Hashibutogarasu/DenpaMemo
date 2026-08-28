import 'package:denpamemo_widgets/denpamemo_widgets.dart' hide BuildContextTranslationsExtension;
import 'package:flutter/material.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

@widgetbook.UseCase(name: 'Default', type: DenpaMenNode, path: 'lineage')
Widget denpaMenNodeUseCase(BuildContext context) {
  return const DenpaMenNode(iconFile: null, name: 'こうた', size: 64);
}
