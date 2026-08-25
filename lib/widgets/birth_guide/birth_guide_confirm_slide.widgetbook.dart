import 'package:flutter/material.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

import '../../widgetbook/denpa_men/denpa_men_data.dart';
import 'birth_guide_confirm_slide.dart';

@widgetbook.UseCase(name: 'Default', type: BirthGuideConfirmSlide, path: 'birth_guide')
Widget birthGuideConfirmSlideUseCase(BuildContext context) {
  return BirthGuideConfirmSlide(
    denpaMen: DenpaMenData.denpaMen,
    totalAttributeCount: DenpaMenData.masterData.attributes.length,
    instruction: 'この内容で確定しますか？',
  );
}
