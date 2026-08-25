import 'package:flutter/material.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

import '../../widgetbook/denpa_men/denpa_men_data.dart';
import 'denpa_men_action_menu.dart';

@widgetbook.UseCase(name: 'Default', type: DenpaMenContextMenuArea, path: 'dialog')
Widget denpaMenContextMenuAreaUseCase(BuildContext context) {
  return DenpaMenContextMenuArea(
    record: DenpaMenData.denpaMenRecord,
    masterData: DenpaMenData.masterData,
    child: const SizedBox(
      width: 200,
      height: 80,
      child: Center(child: Text('長押しまたは右クリック')),
    ),
  );
}
