import 'package:flutter/material.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

import '../../i18n/gen/strings.g.dart';
import 'app_scaffold.dart';

@widgetbook.UseCase(name: 'Default', type: AppScaffold, path: 'scaffold')
Widget appScaffoldUseCase(BuildContext context) {
  return AppScaffold(
    title: Text(context.t.app.name),
    body: const Center(child: Text('本文')),
  );
}

@widgetbook.UseCase(name: 'With Fab', type: AppScaffold, path: 'scaffold')
Widget appScaffoldWithFabUseCase(BuildContext context) {
  return AppScaffold(
    title: Text(context.t.app.name),
    body: const Center(child: Text('本文')),
    floatingActionButton: FloatingActionButton(
      onPressed: () {},
      child: const Icon(Icons.add),
    ),
  );
}
