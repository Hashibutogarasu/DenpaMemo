import 'package:flutter/material.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;
import 'package:denpamemo_widgets/testing.dart';
import 'package:denpamemo_widgets/denpamemo_widgets.dart';


@widgetbook.UseCase(name: 'Default', type: DenpaMenBox, path: 'container')
Widget denpaMenBoxUseCase(BuildContext context) {
  return DenpaMenBox(
    records: [DenpaMenData.denpaMenRecord],
    cellBuilder: (context, record, cellSize) => DenpaMenContainer(
      denpaMen: record.denpaMen,
      size: cellSize,
    ),
  );
}

@widgetbook.UseCase(name: 'Selection Mode', type: DenpaMenBox, path: 'container')
Widget denpaMenBoxSelectionModeUseCase(BuildContext context) {
  return DenpaMenBox(
    records: [DenpaMenData.denpaMenRecord],
    cellBuilder: (context, record, cellSize) => DenpaMenContainer(
      denpaMen: record.denpaMen,
      selectionMode: true,
      selected: record.id == DenpaMenData.denpaMenRecord.id,
      onSelectedChanged: (_) {},
      size: cellSize,
    ),
  );
}
