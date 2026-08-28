import 'package:denpamemo_widgets/denpamemo_widgets.dart';
import 'package:flutter/material.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;
import 'package:denpamemo_widgets/testing.dart';


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
