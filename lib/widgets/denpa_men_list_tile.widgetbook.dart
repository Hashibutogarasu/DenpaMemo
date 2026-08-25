import 'package:flutter/material.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

import '../widgetbook/denpa_men/denpa_men_data.dart';
import 'denpa_men_list_tile.dart';

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
    record: DenpaMenData.denpaMenRecord,
    masterData: DenpaMenData.masterData,
  );
}
