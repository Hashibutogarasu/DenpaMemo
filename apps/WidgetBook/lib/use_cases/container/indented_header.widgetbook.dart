import 'package:denpamemo_widgets/denpamemo_widgets.dart';
import 'package:flutter/material.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;


@widgetbook.UseCase(name: 'Default', type: IndentedHeader, path: 'container')
Widget indentedHeaderUseCase(BuildContext context) {
  return const IndentedHeader(child: Text('見出し'));
}
