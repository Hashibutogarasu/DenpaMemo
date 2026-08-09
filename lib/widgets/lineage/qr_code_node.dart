import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

/// Root node of a [DenpaMenLineageTree](../denpa_men_lineage_tree.dart)
/// section: the QR code itself, rendered as its actual QR image rather
/// than its name/id as text.
class QrCodeNode extends StatelessWidget {
  const QrCodeNode({super.key, required this.rawValue});

  final String rawValue;

  static const double size = 72;

  @override
  Widget build(BuildContext context) {
    return QrImageView(data: rawValue, size: size);
  }
}
