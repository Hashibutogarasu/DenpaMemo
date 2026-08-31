import 'package:denpamemo_widgets/denpamemo_widgets.dart';
import 'package:denpamemo_widgets/testing.dart';
import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;
import '../../core/dialog_preview.dart';

@widgetbook.UseCase(name: 'Default', type: AntennaSelectionDialog, path: 'dialog')
Widget antennaSelectionDialogUseCase(BuildContext context) {
  final masterData = RouteDenpaMenData.masterData;
  final level = context.knobs.int.slider(
    label: 'level',
    initialValue: 3,
    min: 0,
    max: 9,
  );
  final maxSelectableLevel = context.knobs.int.slider(
    label: 'maxSelectableLevel',
    initialValue: 9,
    min: 1,
    max: 20,
  );

  return DialogPreview(
    builder: (context) => AntennaSelectionDialog(
      anntenas: masterData.anntenas,
      initial: masterData.anntenas.first,
      level: level,
      maxSelectableLevel: maxSelectableLevel,
    ),
  );
}
