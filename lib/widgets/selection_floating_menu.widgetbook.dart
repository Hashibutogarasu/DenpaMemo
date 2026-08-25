import 'package:flutter/material.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

import '../widgetbook/denpa_men/denpa_men_data.dart';
import 'selection_floating_menu.dart';

@widgetbook.UseCase(name: 'Default', type: SelectionFloatingMenu, path: 'common')
Widget selectionFloatingMenuUseCase(BuildContext context) {
  return SelectionFloatingMenu(masterData: DenpaMenData.masterData);
}
