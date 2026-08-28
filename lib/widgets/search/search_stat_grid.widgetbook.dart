import 'package:flutter/material.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

import '../../domain/search/denpa_men_search_query.dart';
import 'search_stat_grid.dart';

@widgetbook.UseCase(name: 'Default', type: SearchStatGrid, path: 'search')
Widget searchStatGridUseCase(BuildContext context) {
  return SearchStatGrid(
    query: const DenpaMenSearchQuery(),
    onChanged: (_) {},
  );
}
