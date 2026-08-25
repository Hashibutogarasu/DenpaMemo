import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

import '../../providers/master_data_providers.dart';
import '../../widgetbook/core/dialog_preview.dart';
import 'antenna_selection_dialog.dart';

@widgetbook.UseCase(name: 'Default', type: AntennaSelectionDialog, path: 'dialog')
Widget antennaSelectionDialogUseCase(BuildContext context) {
  return Consumer(
    builder: (context, ref, child) {
      final masterData = ref.watch(masterDataProvider).value!;
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
    },
  );
}
