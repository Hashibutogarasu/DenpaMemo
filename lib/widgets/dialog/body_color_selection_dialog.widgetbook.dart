import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

import '../../widgetbook/core/dialog_preview.dart';
import '../color/body_color_palette.dart';
import 'body_color_selection_dialog.dart';

@widgetbook.UseCase(name: 'Default', type: BodyColorSelectionDialog, path: 'dialog')
Widget bodyColorSelectionDialogUseCase(BuildContext context) {
  final initialColor = context.knobs.object.dropdown<String>(
    label: 'initial color',
    options: bodyColorPalette.keys.toList(),
    labelBuilder: (colorId) => colorId,
  );
  final isSpColor = context.knobs.boolean(label: 'isSpColor', initialValue: false);

  return DialogPreview(
    builder: (context) => BodyColorSelectionDialog(
      initial: [initialColor],
      initialShades: const [0],
      initialIsSpColor: isSpColor,
    ),
  );
}
