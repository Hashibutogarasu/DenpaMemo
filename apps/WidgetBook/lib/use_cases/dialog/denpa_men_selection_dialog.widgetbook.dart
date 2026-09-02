import 'package:data_pack/data_pack.dart';
import 'package:denpamemo_widgets/denpamemo_widgets.dart';
import 'package:denpamemo_widgets/testing.dart';
import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

import '../../core/dialog_preview.dart';

@widgetbook.UseCase(name: 'Default', type: DenpaMenSelectionDialog, path: 'dialog')
Widget denpaMenSelectionDialogUseCase(BuildContext context) {
  final candidates = RouteDenpaMenData.all;
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
      totalAttributeCount: RouteDenpaMenData.masterData.attributes.length,
      iconsById: const {},
    ),
  );
}
