import 'package:data_pack/data_pack.dart';
import 'package:flutter/material.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;
import 'package:denpamemo_widgets/testing.dart';
import 'package:denpamemo_widgets/denpamemo_widgets.dart';

@widgetbook.UseCase(name: 'Default', type: SearchForm, path: 'search')
Widget searchFormUseCase(BuildContext context) {
  return SearchForm(
    headShapes: DenpaMenData.masterData.headShapes,
    anntenas: DenpaMenData.masterData.anntenas,
    query: const DenpaMenSearchQuery(),
    onChanged: (_) {},
  );
}
