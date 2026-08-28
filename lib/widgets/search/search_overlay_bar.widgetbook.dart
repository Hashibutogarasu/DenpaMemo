import 'package:flutter/material.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

import 'search_overlay_bar.dart';

@widgetbook.UseCase(name: 'Default', type: SearchOverlayBar, path: 'search')
Widget searchOverlayBarUseCase(BuildContext context) {
  return const SearchOverlayBar();
}
