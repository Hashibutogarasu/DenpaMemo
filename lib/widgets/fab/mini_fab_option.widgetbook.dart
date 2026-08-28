import 'package:denpamemo_widgets/denpamemo_widgets.dart' hide BuildContextTranslationsExtension;
import 'package:flutter/material.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

import '../../i18n/gen/strings.g.dart';

@widgetbook.UseCase(name: 'Open', type: MiniFabOption, path: 'fab')
Widget miniFabOptionOpenUseCase(BuildContext context) {
  return MiniFabOption(
    label: context.t.home.addSingle,
    icon: Icons.add,
    open: true,
    onPressed: () {},
  );
}

@widgetbook.UseCase(name: 'Closed', type: MiniFabOption, path: 'fab')
Widget miniFabOptionClosedUseCase(BuildContext context) {
  return MiniFabOption(
    label: context.t.home.addSingle,
    icon: Icons.add,
    open: false,
    onPressed: () {},
  );
}
