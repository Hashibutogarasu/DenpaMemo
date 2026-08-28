import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

import 'widgetbook.directories.g.dart';
import 'widgetbook/core/widgetbook_scope.dart';
import 'widgetbook/denpa_men/route_denpa_men_data.dart';
import 'widgetbook/denpa_men/route_denpa_men_seed.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await RouteDenpaMenData.initialize();
  seedRouteDenpaMenIntoObjectBox();
  runApp(const WidgetbookApp());
}

@widgetbook.App()
class WidgetbookApp extends StatelessWidget {
  const WidgetbookApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Widgetbook.material(
      directories: directories,
      appBuilder: widgetbookScope,
    );
  }
}
