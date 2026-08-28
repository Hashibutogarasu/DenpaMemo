import 'package:flutter/material.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

import '../../widgetbook/qr_code/qr_code_data.dart';
import 'birth_guide_qr_slide.dart';

@widgetbook.UseCase(name: 'Default', type: BirthGuideQrSlide, path: 'birth_guide')
Widget birthGuideQrSlideUseCase(BuildContext context) {
  return BirthGuideQrSlide(
    rawValue: QrCodeData.qrCode.rawValue,
    instruction: 'このQRコードを読み込んでください',
  );
}
