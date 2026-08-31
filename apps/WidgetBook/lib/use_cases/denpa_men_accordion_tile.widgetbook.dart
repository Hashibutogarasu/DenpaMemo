import 'package:flutter/material.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;
import 'package:denpamemo_widgets/testing.dart';
import 'package:denpamemo_widgets/denpamemo_widgets.dart';


@widgetbook.UseCase(
  name: 'Default',
  type: DenpaMenAccordionTile,
  path: 'denpa_men',
)
Widget denpaMenAccordionTileDefaultUseCase(BuildContext context) {
  return DenpaMenAccordionTile(
    denpaMen: DenpaMenData.denpaMen,
    totalAttributeCount: DenpaMenData.masterData.attributes.length,
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
    denpaMen: DenpaMenData.denpaMen,
    totalAttributeCount: DenpaMenData.masterData.attributes.length,
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
    denpaMen: DenpaMenData.denpaMen,
    totalAttributeCount: DenpaMenData.masterData.attributes.length,
    selectionMode: false,
    selected: false,
    isCut: true,
    onSelectedChanged: (_) {},
  );
}
