import 'package:flutter/material.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

import 'signed_number.dart';

@widgetbook.UseCase(name: 'Positive', type: SignedNumberText, path: 'label')
Widget signedNumberTextPositiveUseCase(BuildContext context) {
  return const SignedNumberText(value: 42);
}

@widgetbook.UseCase(name: 'Negative', type: SignedNumberText, path: 'label')
Widget signedNumberTextNegativeUseCase(BuildContext context) {
  return const SignedNumberText(value: -7);
}
