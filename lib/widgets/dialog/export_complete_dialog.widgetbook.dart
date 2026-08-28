import 'package:flutter/material.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

import '../../domain/backup/export_result.dart';
import '../../widgetbook/core/dialog_preview.dart';
import '../../widgetbook/denpa_men/denpa_men_data.dart';
import 'export_complete_dialog.dart';

@widgetbook.UseCase(name: 'Default', type: ExportCompleteDialog, path: 'dialog')
Widget exportCompleteDialogUseCase(BuildContext context) {
  return DialogPreview(
    builder: (context) => ExportCompleteDialog(
      result: ExportResult(
        exported: [DenpaMenData.denpaMen, DenpaMenData.build('みらい')],
        orphaned: [DenpaMenData.build('はぐれ')],
      ),
    ),
  );
}

@widgetbook.UseCase(name: 'NoOrphans', type: ExportCompleteDialog, path: 'dialog')
Widget exportCompleteDialogNoOrphansUseCase(BuildContext context) {
  return DialogPreview(
    builder: (context) => ExportCompleteDialog(
      result: ExportResult(exported: [DenpaMenData.denpaMen]),
    ),
  );
}
