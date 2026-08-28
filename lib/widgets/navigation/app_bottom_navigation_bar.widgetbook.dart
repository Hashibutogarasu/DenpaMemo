import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

import '../../widgetbook/core/router_preview.dart';
import 'app_bottom_navigation_bar.dart';

final GoRouter _router = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(path: '/', builder: (context, state) => const AppBottomNavigationBar()),
  ],
);

@widgetbook.UseCase(
  name: 'Default',
  type: AppBottomNavigationBar,
  path: 'navigation',
)
Widget appBottomNavigationBarUseCase(BuildContext context) {
  return routerPreview(_router);
}
