import 'package:denpamemo_widgets/denpamemo_widgets.dart';
import 'package:flutter/material.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;


@widgetbook.UseCase(name: 'Default', type: StatusLabel, path: 'label')
Widget statusLabelUseCase(BuildContext context) {
  return const StatusLabel(child: Text('ステータス'));
}
