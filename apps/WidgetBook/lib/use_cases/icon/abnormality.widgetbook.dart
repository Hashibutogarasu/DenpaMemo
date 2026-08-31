import 'package:denpamemo_widgets/denpamemo_widgets.dart';
import 'package:flutter/material.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;


@widgetbook.UseCase(name: 'Default', type: AbnormalityIcon, path: 'icon')
Widget abnormalityIconUseCase(BuildContext context) {
  return const AbnormalityIcon(icon: Icon(Icons.warning, color: Colors.orange));
}
