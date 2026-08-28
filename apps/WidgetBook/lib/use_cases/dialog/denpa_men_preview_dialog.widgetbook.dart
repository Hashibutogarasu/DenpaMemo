import 'package:flutter/material.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;
import 'package:denpamemo_widgets/testing.dart';
import 'package:denpamemo_widgets/denpamemo_widgets.dart';


@widgetbook.UseCase(name: 'Default', type: DenpaMenPreviewDialog, path: 'dialog')
Widget denpaMenPreviewDialogUseCase(BuildContext context) {
  return DenpaMenPreviewDialog(
    denpaMen: DenpaMenData.denpaMen,
    totalAttributeCount: DenpaMenData.masterData.attributes.length,
  );
}
