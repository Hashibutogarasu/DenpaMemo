import 'package:flutter/material.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

import 'indented_header.dart';

@widgetbook.UseCase(name: 'Default', type: IndentedHeader, path: 'container')
Widget indentedHeaderUseCase(BuildContext context) {
  return const IndentedHeader(child: Text('見出し'));
}
