import 'package:denpamemo_widgets/denpamemo_widgets.dart' hide BuildContextTranslationsExtension;
import 'package:flutter/material.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;


@widgetbook.UseCase(name: 'Default', type: UnfocusOnTap, path: 'common')
Widget unfocusOnTapDefaultUseCase(BuildContext context) {
  return UnfocusOnTap(
    onTap: () {},
    child: Container(
      width: 120,
      height: 80,
      color: Colors.deepPurple,
      alignment: Alignment.center,
      child: const Text('Tap me', style: TextStyle(color: Colors.white)),
    ),
  );
}

@widgetbook.UseCase(name: 'Disabled', type: UnfocusOnTap, path: 'common')
Widget unfocusOnTapDisabledUseCase(BuildContext context) {
  return UnfocusOnTap(
    onTap: () {},
    enabled: false,
    child: Container(
      width: 120,
      height: 80,
      color: Colors.grey,
      alignment: Alignment.center,
      child: const Text('Disabled', style: TextStyle(color: Colors.white)),
    ),
  );
}
