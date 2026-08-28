import 'package:denpamemo_widgets/denpamemo_widgets.dart' hide BuildContextTranslationsExtension;
import 'package:flutter/material.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

import '../widgetbook/denpa_men/denpa_men_data.dart';
import '../widgetbook/qr_code/qr_code_data.dart';

@widgetbook.UseCase(name: 'Default', type: EditableQrCode, path: 'denpa_men')
Widget editableQrCodeDefaultUseCase(BuildContext context) {
  return EditableQrCode(
    denpaMen: DenpaMenData.denpaMen,
    candidates: [QrCodeData.qrCodeRecord],
    onChanged: (_) {},
  );
}

@widgetbook.UseCase(name: 'Disabled', type: EditableQrCode, path: 'denpa_men')
Widget editableQrCodeDisabledUseCase(BuildContext context) {
  return EditableQrCode(
    denpaMen: DenpaMenData.denpaMen,
    candidates: [QrCodeData.qrCodeRecord],
    onChanged: (_) {},
    enabled: false,
  );
}
