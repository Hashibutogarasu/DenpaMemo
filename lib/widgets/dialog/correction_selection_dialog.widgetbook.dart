import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

import '../../domain/master_data/correction.dart';
import '../../widgetbook/core/dialog_preview.dart';
import 'correction_selection_dialog.dart';

@widgetbook.UseCase(name: 'Default', type: CorrectionSelectionDialog, path: 'dialog')
Widget correctionSelectionDialogUseCase(BuildContext context) {
  final corrections = [
    for (var i = 0; i < 3; i++) Correction(id: 'correction-$i', hpBonus: i * 10),
  ];
  final selectedId = context.knobs.object.dropdown<String>(
    label: 'initially selected',
    options: [for (final correction in corrections) correction.id],
    labelBuilder: (id) => id,
  );

  return DialogPreview(
    builder: (context) => CorrectionSelectionDialog(
      corrections: corrections,
      initial: [
        for (final correction in corrections)
          if (correction.id == selectedId) correction,
      ],
    ),
  );
}
