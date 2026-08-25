import 'package:flutter/material.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

import '../../widgetbook/denpa_men/denpa_men_data.dart';
import 'editable_denpa_men_icon.dart';

@widgetbook.UseCase(name: 'Default', type: EditableDenpaMenIcon, path: 'icon')
Widget editableDenpaMenIconUseCase(BuildContext context) {
  return EditableDenpaMenIcon(denpaMenId: DenpaMenData.denpaMen.id, size: 80);
}
