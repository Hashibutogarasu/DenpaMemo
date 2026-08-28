import 'package:flutter/material.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

import 'abnormality.dart';

@widgetbook.UseCase(name: 'Default', type: AbnormalityIcon, path: 'icon')
Widget abnormalityIconUseCase(BuildContext context) {
  return const AbnormalityIcon(icon: Icon(Icons.warning, color: Colors.orange));
}
