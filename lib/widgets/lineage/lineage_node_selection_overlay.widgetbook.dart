import 'package:flutter/material.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

import 'lineage_node_selection_overlay.dart';

@widgetbook.UseCase(
  name: 'Hidden',
  type: LineageNodeSelectionOverlay,
  path: 'lineage',
)
Widget lineageNodeSelectionOverlayHiddenUseCase(BuildContext context) {
  return SizedBox(
    width: 64,
    height: 64,
    child: LineageNodeSelectionOverlay(
      selectionMode: ValueNotifier<bool>(false),
      selectedIds: ValueNotifier<Set<int>>({}),
      recordId: 1,
    ),
  );
}

@widgetbook.UseCase(
  name: 'Selected',
  type: LineageNodeSelectionOverlay,
  path: 'lineage',
)
Widget lineageNodeSelectionOverlaySelectedUseCase(BuildContext context) {
  return SizedBox(
    width: 64,
    height: 64,
    child: LineageNodeSelectionOverlay(
      selectionMode: ValueNotifier<bool>(true),
      selectedIds: ValueNotifier<Set<int>>({1}),
      recordId: 1,
    ),
  );
}
