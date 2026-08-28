import 'package:denpamemo_widgets/denpamemo_widgets.dart' hide BuildContextTranslationsExtension;
import 'package:flutter/material.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;


@widgetbook.UseCase(name: 'Placeholder', type: ResolvedEntityIcon, path: 'icon')
Widget resolvedEntityIconPlaceholderUseCase(BuildContext context) {
  return const ResolvedEntityIcon(file: null, size: 80);
}
