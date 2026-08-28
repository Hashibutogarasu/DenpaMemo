import 'package:denpamemo_widgets/denpamemo_widgets.dart' hide BuildContextTranslationsExtension;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:graphql_client/graphql_client.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

import '../../widgetbook/core/dialog_preview.dart';

@widgetbook.UseCase(name: 'Default', type: HeadShapeSelectionDialog, path: 'dialog')
Widget headShapeSelectionDialogUseCase(BuildContext context) {
  return Consumer(
    builder: (context, ref, child) {
      final masterData = ref.watch(masterDataProvider).value!;
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
    },
  );
}
