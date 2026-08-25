import 'package:flutter/material.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

import '../widgetbook/denpa_men/denpa_men_data.dart';
import 'denpa_men_container.dart';

@widgetbook.UseCase(name: 'Default', type: DenpaMenContainer, path: 'denpa_men')
Widget denpaMenContainerDefaultUseCase(BuildContext context) {
  return DenpaMenContainer(denpaMen: DenpaMenData.denpaMen);
}

@widgetbook.UseCase(name: 'Selected', type: DenpaMenContainer, path: 'denpa_men')
Widget denpaMenContainerSelectedUseCase(BuildContext context) {
  return DenpaMenContainer(
    denpaMen: DenpaMenData.denpaMen,
    selectionMode: true,
    selected: true,
    onSelectedChanged: (_) {},
  );
}
