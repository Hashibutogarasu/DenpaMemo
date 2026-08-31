import 'package:flutter/material.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;
import 'package:denpamemo_widgets/testing.dart';
import 'package:denpamemo_widgets/denpamemo_widgets.dart';


@widgetbook.UseCase(name: 'Default', type: DenpaMenListTile, path: 'denpa_men')
Widget denpaMenListTileDefaultUseCase(BuildContext context) {
  return DenpaMenListTile(denpaMen: DenpaMenData.denpaMen);
}

@widgetbook.UseCase(
  name: 'SelectionMode',
  type: DenpaMenListTile,
  path: 'denpa_men',
)
Widget denpaMenListTileSelectionModeUseCase(BuildContext context) {
  return DenpaMenListTile(
    denpaMen: DenpaMenData.denpaMen,
    selectionMode: true,
    selected: true,
    onSelectedChanged: (_) {},
  );
}

@widgetbook.UseCase(
  name: 'WithActionMenu',
  type: DenpaMenListTile,
  path: 'denpa_men',
)
Widget denpaMenListTileWithActionMenuUseCase(BuildContext context) {
  return DenpaMenListTile(
    denpaMen: DenpaMenData.denpaMen,
    actionMenuItemsBuilder: (context) => [
      PopupMenuItem(value: () {}, child: const Text('編集')),
      PopupMenuItem(value: () {}, child: const Text('削除')),
    ],
  );
}
