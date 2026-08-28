import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;
import 'package:denpamemo_widgets/denpamemo_widgets.dart';

@widgetbook.UseCase(name: 'Default', type: SearchOverlayBar, path: 'search')
Widget searchOverlayBarUseCase(BuildContext context) {
  final open = context.knobs.boolean(label: 'open', initialValue: true);

  return SearchOverlayBar(
    open: open,
    queryName: '',
    onQueryNameChanged: (_) {},
    onClose: () {},
  );
}
