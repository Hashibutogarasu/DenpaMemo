import 'package:flutter/material.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;
import 'package:denpamemo_widgets/testing.dart';
import 'package:denpamemo_widgets/denpamemo_widgets.dart';


@widgetbook.UseCase(name: 'Default', type: BirthGuideIndividualSlide, path: 'birth_guide')
Widget birthGuideIndividualSlideUseCase(BuildContext context) {
  return BirthGuideIndividualSlide(
    denpaMen: DenpaMenData.denpaMen,
    totalAttributeCount: DenpaMenData.masterData.attributes.length,
    instruction: '対象の電波メンを確認してください',
  );
}
