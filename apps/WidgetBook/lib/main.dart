import 'package:denpamemo_widgets/testing.dart';
import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

import 'core/widgetbook_scope.dart';
import 'main.directories.g.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await RouteDenpaMenData.initialize();
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
