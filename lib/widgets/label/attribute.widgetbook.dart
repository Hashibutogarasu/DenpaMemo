import 'package:flutter/material.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

import 'attribute.dart';

@widgetbook.UseCase(name: 'Default', type: AttributeLabel, path: 'label')
Widget attributeLabelUseCase(BuildContext context) {
  return const AttributeLabel(child: Text('火'));
}
