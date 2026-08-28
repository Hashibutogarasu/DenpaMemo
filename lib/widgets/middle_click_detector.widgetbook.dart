import 'package:denpamemo_widgets/denpamemo_widgets.dart' hide BuildContextTranslationsExtension;
import 'package:flutter/material.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;


@widgetbook.UseCase(name: 'Default', type: MiddleClickDetector, path: 'common')
Widget middleClickDetectorUseCase(BuildContext context) {
  return MiddleClickDetector(
    onMiddleClick: () {},
    child: Container(
      width: 120,
      height: 80,
      color: Colors.deepPurple,
      alignment: Alignment.center,
      child: const Text('Middle click me', style: TextStyle(color: Colors.white)),
    ),
  );
}
