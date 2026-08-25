import 'package:flutter/material.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

import '../../widgetbook/denpa_men/denpa_men_data.dart';
import 'search_form.dart';

@widgetbook.UseCase(name: 'Default', type: SearchForm, path: 'search')
Widget searchFormUseCase(BuildContext context) {
  return SearchForm(
    headShapes: DenpaMenData.masterData.headShapes,
    anntenas: DenpaMenData.masterData.anntenas,
  );
}
