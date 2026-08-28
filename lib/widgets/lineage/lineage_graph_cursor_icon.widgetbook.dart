import 'package:flutter/material.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

import 'lineage_graph_cursor_icon.dart';

@widgetbook.UseCase(
  name: 'Default',
  type: LineageGraphCursorIcon,
  path: 'lineage',
)
Widget lineageGraphCursorIconUseCase(BuildContext context) {
  return const LineageGraphCursorIcon();
}
