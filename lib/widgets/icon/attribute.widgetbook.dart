import 'package:flutter/material.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

import 'attribute.dart';

@widgetbook.UseCase(name: 'Default', type: AttributeIcon, path: 'icon')
Widget attributeIconUseCase(BuildContext context) {
  return const AttributeIcon(size: 20);
}
