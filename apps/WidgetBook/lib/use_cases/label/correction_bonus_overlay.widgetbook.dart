import 'package:denpamemo_widgets/denpamemo_widgets.dart';
import 'package:flutter/material.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;


@widgetbook.UseCase(name: 'Active', type: CorrectionBonusOverlay, path: 'label')
Widget correctionBonusOverlayActiveUseCase(BuildContext context) {
  return const SizedBox(
    width: 150,
    height: 30,
    child: Stack(children: [CorrectionBonusOverlay(value: 5)]),
  );
}

@widgetbook.UseCase(name: 'Inactive', type: CorrectionBonusOverlay, path: 'label')
Widget correctionBonusOverlayInactiveUseCase(BuildContext context) {
  return const SizedBox(
    width: 150,
    height: 30,
    child: Stack(children: [CorrectionBonusOverlay(value: -3, active: false)]),
  );
}
