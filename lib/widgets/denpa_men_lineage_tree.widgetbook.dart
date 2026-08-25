import 'package:flutter/material.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

import '../widgetbook/denpa_men/route_denpa_men_data.dart';
import 'denpa_men_lineage_tree.dart';

@widgetbook.UseCase(
  name: 'Default',
  type: DenpaMenLineageTree,
  path: 'denpa_men',
)
Widget denpaMenLineageTreeUseCase(BuildContext context) {
  return DenpaMenLineageTree(masterData: RouteDenpaMenData.masterData);
}
