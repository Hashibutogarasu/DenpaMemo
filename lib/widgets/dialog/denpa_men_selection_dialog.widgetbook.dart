import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

import '../../domain/denpa_men/denpa_men.dart';
import '../../widgetbook/core/dialog_preview.dart';
import '../../widgetbook/denpa_men/route_denpa_men_providers.dart';
import 'denpa_men_selection_dialog.dart';

@widgetbook.UseCase(name: 'Default', type: DenpaMenSelectionDialog, path: 'dialog')
Widget denpaMenSelectionDialogUseCase(BuildContext context) {
  return Consumer(
    builder: (context, ref, child) {
      final candidates = ref.watch(routeDenpaMenListProvider);
      final title = context.knobs.string(
        label: 'title',
        initialValue: '重複する個体を選択',
      );
      final minSelection = context.knobs.int.slider(
        label: 'minSelection',
        initialValue: 1,
        min: 0,
        max: candidates.isEmpty ? 1 : candidates.length,
      );
      final initial = context.knobs.objectOrNull.dropdown<DenpaMen>(
        label: 'initially selected',
        options: candidates,
        defaultToNull: true,
      );

      return DialogPreview(
        builder: (context) => DenpaMenSelectionDialog.internal(
          title: title,
          candidates: candidates,
          initial: initial == null ? const [] : [initial],
          minSelection: minSelection,
        ),
      );
    },
  );
}
