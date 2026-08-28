import 'package:denpamemo_widgets/denpamemo_widgets.dart';
import 'package:denpamemo_widgets/testing.dart';
import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;
import '../../core/dialog_preview.dart';

@widgetbook.UseCase(name: 'Default', type: HeadShapeSelectionDialog, path: 'dialog')
Widget headShapeSelectionDialogUseCase(BuildContext context) {
  final masterData = RouteDenpaMenData.masterData;
  final selectedId = context.knobs.object.dropdown<String>(
    label: 'initially selected',
    options: [for (final headShape in masterData.headShapes) headShape.id],
    labelBuilder: (id) => id,
  );

  return DialogPreview(
    builder: (context) => HeadShapeSelectionDialog(
      headShapes: masterData.headShapes,
      initial: masterData.headShapes.firstWhere(
        (headShape) => headShape.id == selectedId,
      ),
    ),
  );
}
