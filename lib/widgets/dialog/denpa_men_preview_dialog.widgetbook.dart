import 'package:flutter/material.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

import '../../widgetbook/denpa_men/denpa_men_data.dart';
import 'denpa_men_preview_dialog.dart';

@widgetbook.UseCase(name: 'Default', type: DenpaMenPreviewDialog, path: 'dialog')
Widget denpaMenPreviewDialogUseCase(BuildContext context) {
  return DenpaMenPreviewDialog(denpaMen: DenpaMenData.denpaMen);
}
