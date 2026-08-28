import 'package:flutter/material.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

import '../widgetbook/denpa_men/denpa_men_data.dart';
import 'denpa_men_accordion_tile.dart';

@widgetbook.UseCase(
  name: 'Default',
  type: DenpaMenAccordionTile,
  path: 'denpa_men',
)
Widget denpaMenAccordionTileDefaultUseCase(BuildContext context) {
  return DenpaMenAccordionTile(
    record: DenpaMenData.denpaMenRecord,
    masterData: DenpaMenData.masterData,
    selectionMode: false,
    selected: false,
    isCut: false,
    onSelectedChanged: (_) {},
  );
}

@widgetbook.UseCase(
  name: 'SelectionModeSelected',
  type: DenpaMenAccordionTile,
  path: 'denpa_men',
)
Widget denpaMenAccordionTileSelectionModeSelectedUseCase(
  BuildContext context,
) {
  return DenpaMenAccordionTile(
    record: DenpaMenData.denpaMenRecord,
    masterData: DenpaMenData.masterData,
    selectionMode: true,
    selected: true,
    isCut: false,
    onSelectedChanged: (_) {},
  );
}

@widgetbook.UseCase(
  name: 'Cut',
  type: DenpaMenAccordionTile,
  path: 'denpa_men',
)
Widget denpaMenAccordionTileCutUseCase(BuildContext context) {
  return DenpaMenAccordionTile(
    record: DenpaMenData.denpaMenRecord,
    masterData: DenpaMenData.masterData,
    selectionMode: false,
    selected: false,
    isCut: true,
    onSelectedChanged: (_) {},
  );
}
