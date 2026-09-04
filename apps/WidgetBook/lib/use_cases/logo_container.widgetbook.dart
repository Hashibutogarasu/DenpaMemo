import 'package:denpamemo_widgets/denpamemo_widgets.dart';
import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

@widgetbook.UseCase(name: 'Default', type: LogoContainer, path: 'common')
Widget logoContainerUseCase(BuildContext context) {
  final appName = context.knobs.string(
    label: 'アプリ名',
    initialValue: 'Denpa Memo',
  );

  return LogoContainer(
    icon: const Icon(Icons.apps, size: 64),
    appName: appName,
  );
}
