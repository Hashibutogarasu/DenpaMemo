import 'package:flutter/material.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

import '../widgetbook/denpa_men/denpa_men_data.dart';
import 'add_denpa_men_fab.dart';

@widgetbook.UseCase(name: 'Default', type: AddDenpaMenFab, path: 'denpa_men')
Widget addDenpaMenFabDefaultUseCase(BuildContext context) {
  return AddDenpaMenFab(masterData: DenpaMenData.masterData);
}

@widgetbook.UseCase(
  name: 'WithImportExport',
  type: AddDenpaMenFab,
  path: 'denpa_men',
)
Widget addDenpaMenFabWithImportExportUseCase(BuildContext context) {
  return AddDenpaMenFab(
    masterData: DenpaMenData.masterData,
    onImport: () {},
    onExport: () {},
  );
}
