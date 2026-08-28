import 'package:denpamemo_widgets/denpamemo_widgets.dart';
import 'package:flutter/material.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;


@widgetbook.UseCase(name: 'Default', type: SlantedAppBar, path: 'header')
Widget slantedAppBarUseCase(BuildContext context) {
  return SlantedAppBar(title: Text('Denpa Memo'));
}

@widgetbook.UseCase(name: 'With Actions', type: SlantedAppBar, path: 'header')
Widget slantedAppBarWithActionsUseCase(BuildContext context) {
  return SlantedAppBar(
    title: Text('Denpa Memo'),
    actions: [
      IconButton(icon: const Icon(Icons.search), onPressed: () {}),
      IconButton(icon: const Icon(Icons.more_vert), onPressed: () {}),
    ],
  );
}
