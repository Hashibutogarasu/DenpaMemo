import 'package:denpamemo_widgets/denpamemo_widgets.dart';
import 'package:flutter/material.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;


@widgetbook.UseCase(name: 'Open', type: MiniFabOption, path: 'fab')
Widget miniFabOptionOpenUseCase(BuildContext context) {
  return MiniFabOption(
    label: '単体で追加',
    icon: Icons.add,
    open: true,
    onPressed: () {},
  );
}

@widgetbook.UseCase(name: 'Closed', type: MiniFabOption, path: 'fab')
Widget miniFabOptionClosedUseCase(BuildContext context) {
  return MiniFabOption(
    label: '単体で追加',
    icon: Icons.add,
    open: false,
    onPressed: () {},
  );
}
