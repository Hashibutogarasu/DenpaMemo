import 'package:flutter/material.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

import '../../widgetbook/denpa_men/denpa_men_data.dart';
import 'birth_guide_individual_slide.dart';

@widgetbook.UseCase(name: 'Default', type: BirthGuideIndividualSlide, path: 'birth_guide')
Widget birthGuideIndividualSlideUseCase(BuildContext context) {
  return BirthGuideIndividualSlide(
    denpaMen: DenpaMenData.denpaMen,
    totalAttributeCount: DenpaMenData.masterData.attributes.length,
    instruction: '対象の電波メンを確認してください',
  );
}
