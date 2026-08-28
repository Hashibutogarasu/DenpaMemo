import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

/// Shows [rawValue] as a large [QrImageView] in a dialog, used when
/// tapping a QR code node in
/// [LineageGraph](../lineage/lineage_graph.dart).
class QrCodeImageDialog extends StatelessWidget {
  const QrCodeImageDialog({super.key, required this.rawValue});

  final String rawValue;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: QrImageView(data: rawValue, size: 280),
      ),
    );
  }
}
