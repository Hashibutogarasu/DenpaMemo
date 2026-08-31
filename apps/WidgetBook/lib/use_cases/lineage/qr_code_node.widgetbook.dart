import 'package:denpamemo_widgets/denpamemo_widgets.dart';
import 'package:flutter/material.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

@widgetbook.UseCase(name: 'Default', type: QrCodeNode, path: 'lineage')
Widget qrCodeNodeUseCase(BuildContext context) {
  return const QrCodeNode(rawValue: 'widgetbook-qr', size: 96);
}
