import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

import '../../widgetbook/core/router_preview.dart';
import 'app_shell.dart';

final GoRouter _router = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const AppShell(child: Center(child: Text('本文'))),
    ),
  ],
);

@widgetbook.UseCase(name: 'Default', type: AppShell, path: 'scaffold')
Widget appShellUseCase(BuildContext context) {
  return routerPreview(_router);
}
