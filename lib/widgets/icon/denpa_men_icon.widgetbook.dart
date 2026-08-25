import 'package:flutter/material.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

import '../../widgetbook/denpa_men/denpa_men_data.dart';
import 'denpa_men_icon.dart';

@widgetbook.UseCase(name: 'Default', type: DenpaMenIcon, path: 'icon')
Widget denpaMenIconUseCase(BuildContext context) {
  return DenpaMenIcon(denpaMenId: DenpaMenData.denpaMen.id, size: 80);
}
