import 'package:denpamemo_widgets/denpamemo_widgets.dart' hide BuildContextTranslationsExtension;
import 'package:flutter/material.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;


@widgetbook.UseCase(name: 'Default', type: ToggleButtonGroup, path: 'home')
Widget toggleButtonGroupUseCase(BuildContext context) {
  return ToggleButtonGroup<int>(
    values: const [0, 1],
    selected: 0,
    onChanged: (_) {},
    children: const [Icon(Icons.view_list), Icon(Icons.grid_view)],
  );
}
