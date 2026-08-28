import 'package:denpamemo_widgets/denpamemo_widgets.dart' hide BuildContextTranslationsExtension;
import 'package:flutter/material.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;


@widgetbook.UseCase(
  name: 'Default',
  type: DenpaMenSelectedOverlay,
  path: 'denpa_men',
)
Widget denpaMenSelectedOverlayUseCase(BuildContext context) {
  return const SizedBox(
    width: 56,
    height: 56,
    child: DenpaMenSelectedOverlay(),
  );
}
