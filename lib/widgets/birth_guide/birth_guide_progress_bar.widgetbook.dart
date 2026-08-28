import 'package:denpamemo_widgets/denpamemo_widgets.dart' hide BuildContextTranslationsExtension;
import 'package:flutter/material.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;


@widgetbook.UseCase(name: 'InProgress', type: BirthGuideProgressBar, path: 'birth_guide')
Widget birthGuideProgressBarInProgressUseCase(BuildContext context) {
  return const BirthGuideProgressBar(current: 2, total: 5);
}

@widgetbook.UseCase(name: 'Complete', type: BirthGuideProgressBar, path: 'birth_guide')
Widget birthGuideProgressBarCompleteUseCase(BuildContext context) {
  return const BirthGuideProgressBar(current: 5, total: 5);
}
