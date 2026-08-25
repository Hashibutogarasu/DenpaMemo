import 'package:flutter/material.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

import 'status.dart';

@widgetbook.UseCase(name: 'Default', type: StatusContainer, path: 'container')
Widget statusContainerUseCase(BuildContext context) {
  return const StatusContainer(child: Text('ステータス'));
}
