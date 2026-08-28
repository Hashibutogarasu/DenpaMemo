import 'package:denpamemo_widgets/denpamemo_widgets.dart' hide BuildContextTranslationsExtension;
import 'package:flutter/material.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

import '../../widgetbook/qr_code/qr_code_data.dart';

@widgetbook.UseCase(name: 'Default', type: QrCodeImageDialog, path: 'dialog')
Widget qrCodeImageDialogUseCase(BuildContext context) {
  return QrCodeImageDialog(rawValue: QrCodeData.qrCode.rawValue);
}
