import 'package:flutter/material.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

import '../../i18n/gen/strings.g.dart';
import 'slanted_app_bar.dart';

@widgetbook.UseCase(name: 'Default', type: SlantedAppBar, path: 'header')
Widget slantedAppBarUseCase(BuildContext context) {
  return SlantedAppBar(title: Text(context.t.app.name));
}

@widgetbook.UseCase(name: 'With Actions', type: SlantedAppBar, path: 'header')
Widget slantedAppBarWithActionsUseCase(BuildContext context) {
  return SlantedAppBar(
    title: Text(context.t.app.name),
    actions: [
      IconButton(icon: const Icon(Icons.search), onPressed: () {}),
      IconButton(icon: const Icon(Icons.more_vert), onPressed: () {}),
    ],
  );
}
