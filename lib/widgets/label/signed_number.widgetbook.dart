import 'package:denpamemo_widgets/denpamemo_widgets.dart' hide BuildContextTranslationsExtension;
import 'package:flutter/material.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;


@widgetbook.UseCase(name: 'Positive', type: SignedNumberText, path: 'label')
Widget signedNumberTextPositiveUseCase(BuildContext context) {
  return const SignedNumberText(value: 42);
}

@widgetbook.UseCase(name: 'Negative', type: SignedNumberText, path: 'label')
Widget signedNumberTextNegativeUseCase(BuildContext context) {
  return const SignedNumberText(value: -7);
}
