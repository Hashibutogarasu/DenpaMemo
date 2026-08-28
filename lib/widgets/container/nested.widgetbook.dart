import 'package:denpamemo_widgets/denpamemo_widgets.dart' hide BuildContextTranslationsExtension;
import 'package:flutter/material.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;


@widgetbook.UseCase(name: 'Default', type: NestedContainer, path: 'container')
Widget nestedContainerUseCase(BuildContext context) {
  return const NestedContainer(child: Text('コンテンツ'));
}
