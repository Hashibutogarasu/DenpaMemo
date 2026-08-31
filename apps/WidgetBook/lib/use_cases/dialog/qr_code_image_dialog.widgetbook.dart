import 'package:denpamemo_widgets/denpamemo_widgets.dart';
import 'package:flutter/material.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;
import 'package:denpamemo_widgets/testing.dart';


@widgetbook.UseCase(name: 'Default', type: QrCodeImageDialog, path: 'dialog')
Widget qrCodeImageDialogUseCase(BuildContext context) {
  return QrCodeImageDialog(rawValue: QrCodeData.qrCode.rawValue);
}
