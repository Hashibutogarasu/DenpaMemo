import 'package:flutter/material.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;
import 'package:denpamemo_widgets/testing.dart';
import 'package:denpamemo_widgets/denpamemo_widgets.dart';


@widgetbook.UseCase(name: 'Default', type: BirthGuideConfirmSlide, path: 'birth_guide')
Widget birthGuideConfirmSlideUseCase(BuildContext context) {
  return BirthGuideConfirmSlide(
    denpaMen: DenpaMenData.denpaMen,
    totalAttributeCount: DenpaMenData.masterData.attributes.length,
    instruction: 'この内容で確定しますか？',
  );
}
