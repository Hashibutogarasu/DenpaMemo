import 'package:data_pack/data_pack.dart';
import 'package:denpamemo_widgets/denpamemo_widgets.dart';
import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;
import '../../core/dialog_preview.dart';


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
