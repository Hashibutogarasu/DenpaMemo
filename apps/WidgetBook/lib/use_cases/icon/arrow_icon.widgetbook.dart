import 'package:denpamemo_widgets/denpamemo_widgets.dart';
import 'package:flutter/material.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

@widgetbook.UseCase(name: 'To Cloud (Static)', type: ArrowIcon, path: 'icon')
Widget arrowIconToCloudStaticUseCase(BuildContext context) {
  return const ArrowIcon(direction: ArrowDirection.toCloud);
}

@widgetbook.UseCase(name: 'To Cloud (Animating)', type: ArrowIcon, path: 'icon')
Widget arrowIconToCloudAnimatingUseCase(BuildContext context) {
  return const ArrowIcon(direction: ArrowDirection.toCloud, isAnimating: true);
}

@widgetbook.UseCase(name: 'To Local (Animating)', type: ArrowIcon, path: 'icon')
Widget arrowIconToLocalAnimatingUseCase(BuildContext context) {
  return const ArrowIcon(direction: ArrowDirection.toLocal, isAnimating: true);
}
