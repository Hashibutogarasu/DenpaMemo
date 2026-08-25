import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

import '../../domain/qr_code/qr_code_record.dart';
import '../../widgetbook/core/dialog_preview.dart';
import '../../widgetbook/qr_code/qr_code_data.dart';
import 'qr_code_selection_dialog.dart';

@widgetbook.UseCase(name: 'Default', type: QrCodeSelectionDialog, path: 'dialog')
Widget qrCodeSelectionDialogUseCase(BuildContext context) {
  final candidateCount = context.knobs.int.slider(
    label: 'candidate count',
    initialValue: 1,
    min: 0,
    max: 5,
  );
  final hasInitialSelection = context.knobs.boolean(
    label: 'initially selected',
    initialValue: true,
  );
  final candidates = [
    for (var i = 0; i < candidateCount; i++)
      QrCodeRecord(id: i, qrCode: QrCodeData.qrCode),
  ];

  return DialogPreview(
    builder: (context) => QrCodeSelectionDialog(
      candidates: candidates,
      initial: hasInitialSelection && candidates.isNotEmpty
          ? candidates.first
          : null,
    ),
  );
}
