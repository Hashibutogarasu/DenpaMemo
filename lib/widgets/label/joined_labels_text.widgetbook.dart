import 'package:denpamemo_widgets/denpamemo_widgets.dart' hide BuildContextTranslationsExtension;
import 'package:flutter/material.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;


@widgetbook.UseCase(name: 'Joined', type: JoinedLabelsText, path: 'label')
Widget joinedLabelsTextJoinedUseCase(BuildContext context) {
  return const JoinedLabelsText(labels: ['でんぱメン1号', 'でんぱメン2号']);
}

@widgetbook.UseCase(name: 'Empty', type: JoinedLabelsText, path: 'label')
Widget joinedLabelsTextEmptyUseCase(BuildContext context) {
  return const JoinedLabelsText(labels: []);
}
