import 'package:flutter/material.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

import 'nested.dart';

@widgetbook.UseCase(name: 'Default', type: NestedContainer, path: 'container')
Widget nestedContainerUseCase(BuildContext context) {
  return const NestedContainer(child: Text('コンテンツ'));
}
