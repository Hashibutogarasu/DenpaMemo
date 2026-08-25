import 'package:flutter/material.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

import 'denpa_men_selected_overlay.dart';

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
