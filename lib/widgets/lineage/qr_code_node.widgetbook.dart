import 'package:flutter/material.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

import 'qr_code_node.dart';

@widgetbook.UseCase(name: 'Default', type: QrCodeNode, path: 'lineage')
Widget qrCodeNodeUseCase(BuildContext context) {
  return const QrCodeNode(rawValue: 'widgetbook-qr', size: 96);
}
