import 'package:flutter/material.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

import '../../domain/backup/dm_import_error.dart';
import '../../domain/backup/import_result.dart';
import '../../widgetbook/core/dialog_preview.dart';
import '../../widgetbook/denpa_men/denpa_men_data.dart';
import 'import_complete_dialog.dart';

@widgetbook.UseCase(name: 'Default', type: ImportCompleteDialog, path: 'dialog')
Widget importCompleteDialogUseCase(BuildContext context) {
  return DialogPreview(
    builder: (context) => ImportCompleteDialog(
      result: ImportResult(
        added: [DenpaMenData.denpaMen],
        merged: [DenpaMenData.build('みらい')],
        orphaned: [DenpaMenData.build('はぐれ')],
        failed: [const DenpaMenEntryParseError(index: 0, rawEntry: null)],
      ),
    ),
  );
}

@widgetbook.UseCase(name: 'NoFailures', type: ImportCompleteDialog, path: 'dialog')
Widget importCompleteDialogNoFailuresUseCase(BuildContext context) {
  return DialogPreview(
    builder: (context) => ImportCompleteDialog(
      result: ImportResult(added: [DenpaMenData.denpaMen]),
    ),
  );
}
