import 'package:data_pack/data_pack.dart';
import 'package:denpamemo_widgets/denpamemo_widgets.dart';
import 'package:flutter/material.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;


@widgetbook.UseCase(name: 'Default', type: SearchStatGrid, path: 'search')
Widget searchStatGridUseCase(BuildContext context) {
  return SearchStatGrid(
    query: const DenpaMenSearchQuery(),
    onChanged: (_) {},
  );
}
