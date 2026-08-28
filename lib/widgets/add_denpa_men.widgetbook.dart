import 'package:flutter/material.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

import '../widgetbook/denpa_men/denpa_men_data.dart';
import '../widgetbook/qr_code/qr_code_data.dart';
import 'add_denpa_men.dart';

@widgetbook.UseCase(name: 'Default', type: AddDenpaMen, path: 'denpa_men')
Widget addDenpaMenUseCase(BuildContext context) {
  return AddDenpaMen(
    denpaMen: DenpaMenData.denpaMen,
    masterData: DenpaMenData.masterData,
    qrCodeCandidates: [QrCodeData.qrCodeRecord],
    onChanged: (_) {},
  );
}
