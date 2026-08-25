import 'package:flutter/material.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

import '../../widgetbook/denpa_men/denpa_men_data.dart';
import 'denpa_men_box.dart';

@widgetbook.UseCase(name: 'Default', type: DenpaMenBox, path: 'container')
Widget denpaMenBoxUseCase(BuildContext context) {
  return DenpaMenBox(
    records: [DenpaMenData.denpaMenRecord],
    selectionMode: false,
    selectedIds: const {},
    cutIds: const {},
    onSelectedChanged: (id, selected) {},
    onTapRecord: (_) {},
  );
}

@widgetbook.UseCase(name: 'Selection Mode', type: DenpaMenBox, path: 'container')
Widget denpaMenBoxSelectionModeUseCase(BuildContext context) {
  return DenpaMenBox(
    records: [DenpaMenData.denpaMenRecord],
    selectionMode: true,
    selectedIds: {DenpaMenData.denpaMenRecord.id},
    cutIds: const {},
    onSelectedChanged: (id, selected) {},
    onTapRecord: (_) {},
  );
}
